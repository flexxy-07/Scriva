import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/shared/widgets/export_sheet.dart';
import 'history_controller.dart';
import '../domain/history_state.dart';
import '../domain/transcript_entry.dart';
import '../../../shared/theme/app_theme.dart';
import '../../transcription/presentation/transcription_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ARCHIVE',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTechnicalSearchBar(),
            Expanded(
              child: switch (state.status) {
                HistoryStatus.idle ||
                HistoryStatus.loading =>
                  const Center(
                    child: SizedBox(
                      width: 100,
                      height: 2,
                      child: LinearProgressIndicator(color: AppColors.primary),
                    ),
                  ),
                HistoryStatus.empty => _buildEmpty(),
                HistoryStatus.loaded => _buildList(state.entries),
                HistoryStatus.error => _buildError(),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalSearchBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surface2, width: 1),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'SEARCH TRANSCRIPTS...',
          hintStyle: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
          border: InputBorder.none,
          icon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
        ),
        onChanged: (q) =>
            ref.read(historyControllerProvider.notifier).search(q),
      ),
    );
  }

  Widget _buildList(List<TransciptEntry> entries) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: entries.length,
      itemBuilder: (_, i) => _TranscriptCard(
        entry: entries[i],
        onDelete: () => ref
            .read(historyControllerProvider.notifier)
            .deleteEntry(entries[i].id),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TranscriptionScreen(
              audioPath: entries[i].audioPath,
              savedEntry: entries[i],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history,
              color: AppColors.surface2, size: 64),
          const SizedBox(height: 24),
          Text(
            'ARCHIVE EMPTY',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline,
              color: AppColors.error, size: 48),
          const SizedBox(height: 16),
          Text(
            'ERROR LOADING HISTORY',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.error,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () =>
                ref.read(historyControllerProvider.notifier).loadHistory(),
            child: Text(
              'RETRY',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TranscriptCard extends StatelessWidget {
  final TransciptEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _TranscriptCard({
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => ExportSheet.show(context, entry),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.surface2, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.title.toUpperCase(),
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.formattedDuration,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                entry.rawTranscript,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.6,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    _formatDate(entry.createdAt).toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textSecondary.withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Spacer(),
                  if (entry.cleanedTranscript != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                      ),
                      child: Text(
                        'CLEANED',
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
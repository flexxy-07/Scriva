import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/core/services/export_service.dart';
import 'package:scriva/features/history/domain/transcript_entry.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ExportSheet extends ConsumerStatefulWidget {
  final TransciptEntry entry;

  const ExportSheet({super.key, required this.entry});

  static void show(BuildContext context, TransciptEntry entry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExportSheet(entry: entry),
    );
  }

  @override
  ConsumerState<ExportSheet> createState() => _ExportSheetState();
}

class _ExportSheetState extends ConsumerState<ExportSheet> {
  bool _useCleaned = false;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _useCleaned = widget.entry.cleanedTranscript != null;
  }

  @override
  Widget build(BuildContext context) {
    final hasCleaned = widget.entry.cleanedTranscript != null;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPORT MODULE',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 32),

          if (hasCleaned) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.surface2, width: 1),
              ),
              child: Row(
                children: [
                  _VersionTab(
                    label: 'RAW',
                    isSelected: !_useCleaned,
                    onTap: () => setState(() => _useCleaned = false),
                  ),
                  _VersionTab(
                    label: 'CLEANED',
                    isSelected: _useCleaned,
                    onTap: () => setState(() => _useCleaned = true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],

          Text(
            'OUTPUT FORMAT',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _FormatCard(
                  label: 'PLAIN TEXT',
                  ext: '.TXT',
                  icon: Icons.text_snippet,
                  isLoading: _isExporting,
                  onTap: () => _export(ExportFormat.txt),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FormatCard(
                  label: 'MARKDOWN',
                  ext: '.MD',
                  icon: Icons.code,
                  isLoading: _isExporting,
                  onTap: () => _export(ExportFormat.markdown),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _QuickShareButton(
            onTap: _isExporting ? null : () => _shareText(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _export(ExportFormat format) async {
    if (_isExporting) return;
    setState(() => _isExporting = true);

    try {
      await ref.read(exportServiceProvider).exportAndShare(
            entry: widget.entry,
            format: format,
            useCleaned: _useCleaned,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('EXPORT FAILED: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _shareText() async {
    final text = _useCleaned && widget.entry.cleanedTranscript != null
        ? widget.entry.cleanedTranscript!
        : widget.entry.rawTranscript;
    await ref
        .read(exportServiceProvider)
        .shareText(text, 'SCRIVA - ${widget.entry.title}');
  }
}

class _VersionTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _VersionTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _FormatCard extends StatelessWidget {
  final String label;
  final String ext;
  final IconData icon;
  final bool isLoading;
  final VoidCallback onTap;

  const _FormatCard({
    required this.label,
    required this.ext,
    required this.icon,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: AppColors.surface2,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const Spacer(),
                if (isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                else
                  const Icon(Icons.share,
                      color: AppColors.textSecondary, size: 14),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              ext,
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickShareButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _QuickShareButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.share,
                color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 12),
            Text(
              'SHARE AS RAW TEXT',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/export_service.dart';
import '../../features/history/domain/transcript_entry.dart';
import '../theme/app_theme.dart';

class ExportSheet extends ConsumerStatefulWidget {
  final TransciptEntry entry;

  const ExportSheet({super.key, required this.entry});

  static Future<void> show(BuildContext context, TransciptEntry entry) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Export Transcript',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          if (hasCleaned) ...[
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _VersionTab(
                    label: 'Raw',
                    isSelected: !_useCleaned,
                    onTap: () => setState(() => _useCleaned = false),
                  ),
                  _VersionTab(
                    label: '✨ Cleaned',
                    isSelected: _useCleaned,
                    onTap: () => setState(() => _useCleaned = true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Format options
          const Text(
            'FORMAT',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _FormatCard(
                  label: 'Plain Text',
                  ext: '.txt',
                  icon: Icons.text_snippet_outlined,
                  isLoading: _isExporting,
                  onTap: () => _export(ExportFormat.txt),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FormatCard(
                  label: 'Markdown',
                  ext: '.md',
                  icon: Icons.code_rounded,
                  isLoading: _isExporting,
                  onTap: () => _export(ExportFormat.markdown),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _QuickShareButton(
            onTap: _isExporting ? null : () => _shareText(),
          ),
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
            content: Text('Export failed: $e'),
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
        .shareText(text, 'Scriva — ${widget.entry.title}');
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : AppColors.textSecondary,
              fontSize: 14,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(14),
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
                Icon(icon, color: AppColors.primary, size: 22),
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
                  const Icon(Icons.share_rounded,
                      color: AppColors.textSecondary, size: 16),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ext,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ios_share_rounded,
                color: AppColors.textSecondary, size: 18),
            SizedBox(width: 8),
            Text(
              'Share as text',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
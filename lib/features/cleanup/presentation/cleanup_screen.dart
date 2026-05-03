import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cleanup_controller.dart';
import '../domain/cleanup_mode.dart';
import '../domain/cleanup_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';

part 'views/cleanup_idle_view.dart';
part 'views/cleanup_loading_view.dart';
part 'views/cleanup_done_view.dart';
part 'views/cleanup_error_view.dart';

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied to clipboard'),
      backgroundColor: AppColors.surface2,
      duration: Duration(seconds: 2),
    ),
  );
}

class CleanupScreen extends ConsumerWidget {
  final String rawTranscript;
  const CleanupScreen({super.key, required this.rawTranscript});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cleanupControllerProvider(rawTranscript));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Cleanup'),
        actions: [
          if (state.isDone)
            IconButton(
              icon: const Icon(Icons.copy_rounded,
                  color: AppColors.textSecondary),
              onPressed: () =>
                  _copyToClipboard(context, state.cleanedText!),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _ModeSelector(rawTranscript: rawTranscript),
            Expanded(
              child: switch (state.status) {
                CleanupStatus.idle => _IdleView(rawTranscript: rawTranscript, state: state),
                CleanupStatus.loading => _LoadingView(state: state),
                CleanupStatus.done => _DoneView(rawTranscript: rawTranscript, state: state),
                CleanupStatus.error => _ErrorView(rawTranscript: rawTranscript, state: state),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeSelector extends ConsumerWidget {
  final String rawTranscript;
  const _ModeSelector({required this.rawTranscript});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cleanupControllerProvider(rawTranscript));
    final controller =
        ref.read(cleanupControllerProvider(rawTranscript).notifier);

    return Container(
      height: 48,
      color: AppColors.surface,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: CleanupMode.values.map((mode) {
          final isSelected = state.selectedMode == mode;
          return GestureDetector(
            onTap: () => controller.selectMode(mode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surface2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${mode.icon} ${mode.label}',
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 16),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
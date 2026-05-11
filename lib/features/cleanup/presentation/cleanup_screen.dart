import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/core/services/settings_service.dart';
import 'cleanup_controller.dart';
import '../domain/cleanup_mode.dart';
import '../domain/cleanup_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import 'package:scriva/shared/widgets/technical_animations.dart';
import 'package:google_fonts/google_fonts.dart';

part 'views/cleanup_idle_view.dart';
part 'views/cleanup_loading_view.dart';
part 'views/cleanup_done_view.dart';
part 'views/cleanup_error_view.dart';

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'COPIED TO CLIPBOARD',
        style: GoogleFonts.spaceGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
      backgroundColor: AppColors.surface2,
      duration: const Duration(seconds: 2),
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
        title: Text(
          'AI CLEANUP MODULE',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          if (state.isDone)
            IconButton(
              icon: const Icon(Icons.content_copy,
                  color: AppColors.textSecondary, size: 20),
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
      height: 56,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.surface2, width: 1),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: CleanupMode.values.map((mode) {
          final isSelected = state.selectedMode == mode;
          return GestureDetector(
            onTap: () => controller.selectMode(mode),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.surface2,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  mode.label.toUpperCase(),
                  style: GoogleFonts.spaceGrotesk(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 12),
            Text(
              label.toUpperCase(),
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
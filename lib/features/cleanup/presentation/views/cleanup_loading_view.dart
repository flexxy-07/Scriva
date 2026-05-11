part of '../cleanup_screen.dart';

class _LoadingView extends ConsumerWidget {
  final CleanupState state;

  const _LoadingView({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TechnicalPulseAnimation(),
          const SizedBox(height: 32),
          Text(
            'ENGINE ACTIVE',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'APPLYING ${state.selectedMode.label.toUpperCase()} MODULE...',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'GEMINI CORE PROCESSING TRANSCRIPT',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary.withOpacity(0.6),
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

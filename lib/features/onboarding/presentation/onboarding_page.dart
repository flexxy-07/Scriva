part of './onboarding_screen.dart';

class _OnboardingPage extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.surface2, width: 2),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(height: 64),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.8,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
part of './onboarding_screen.dart';

class _OnboardingPage extends StatelessWidget{
  final String emoji;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.symmetric(
      horizontal: 32
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          emoji, style: const TextStyle(
            fontSize: 72
          ),
        ),
        const SizedBox(height: 32,),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16,),
        Text(
          subtitle, style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.6
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
    );
  }
}
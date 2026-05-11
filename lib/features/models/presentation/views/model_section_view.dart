part of '../model_manager_screen.dart';

class _ModelSectionView extends ConsumerWidget {
  final List<ModelInfo> models;
  
  const _ModelSectionView({required this.models});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final required = models.where((m) => m.isRequired).toList();
    final optional = models.where((m) => !m.isRequired).toList();
    return ListView(
      children: [
        Text(
          'SYSTEM CRITICAL',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        ...required.map((model) => _ModelCard(model: model)),

        const SizedBox(height: 32),
        Text(
          'ADDITIONAL MODULES',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'INITIALIZE GEMINI CORE FOR ADVANCED CLEANUP',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary.withOpacity(0.6),
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 16),
        ...optional.map((m) => _ModelCard(model: m))
      ]
    );
  }
}

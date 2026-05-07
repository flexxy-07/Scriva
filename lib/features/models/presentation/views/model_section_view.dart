part of '../model_manager_screen.dart';

class _ModelSectionView extends ConsumerWidget {
  final List<ModelInfo> models;
  
  const _ModelSectionView({required this.models});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final required = models.where((m) => m.isRequired).toList();
    final optional = models.where((m) => !m.isRequired).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        ...required.map((model) => _ModelCard(model: model)),

        const Text(
          'OPTIONAL',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Download Gemma to enable fully offline Cleanup',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),

        const SizedBox(height: 12),
        ...optional.map((m) => _ModelCard(model: m))
      ]

    );
  }
}

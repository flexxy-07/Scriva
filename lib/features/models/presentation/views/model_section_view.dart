part of '../model_manager_screen.dart';

class _ModelSectionView extends StatelessWidget {
  final List<ModelInfo> models;
  
  const _ModelSectionView({required this.models});

  @override
  Widget build(BuildContext context) {
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
        ...models.map((model) => _ModelCard(model: model)),
      ],
    );
  }
}

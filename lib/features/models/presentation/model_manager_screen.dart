import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/models/presentation/model_controller.dart';
import '../domain/model_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../recording/presentation/recording_screen.dart';

class ModelManagerScreen extends ConsumerWidget {
  const ModelManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ref.watch(modelControllerProvider);
    final isReady = ref.watch(isAppReadyProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _buildHeader(),
              const SizedBox(height: 48),
              _buildModelSection(context, models, ref),
              const Spacer(),
              if (isReady) _buildContinueButton(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.mic_rounded,
                  color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Scriva',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'AI models setup',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Scriva runs entirely on your device.\nDownload the models once and work offline forever.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildModelSection(
      BuildContext context, List<ModelInfo> models, WidgetRef ref) {
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

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        label: 'Continue to Scriva',
        icon: Icons.arrow_forward_rounded,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RecordingScreen()),
        ),
      ),
    );
  }
}

class _ModelCard extends ConsumerWidget {
  final ModelInfo model;
  const _ModelCard({required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _borderColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusIcon(status: model.status),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${model.sizeMb} MB · Speech recognition',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _ActionButton(model: model),
            ],
          ),
          if (model.isDownloading) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: model.downloadProgress,
                backgroundColor: AppColors.surface2,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${(model.downloadProgress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
          if (model.status == ModelStatus.error && model.errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              model.errorMessage!,
              style: const TextStyle(color: AppColors.error, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  Color get _borderColor {
    switch (model.status) {
      case ModelStatus.downloaded:
        return AppColors.success;
      case ModelStatus.downloading:
        return AppColors.primary;
      case ModelStatus.error:
        return AppColors.error;
      case ModelStatus.notDownloaded:
        return AppColors.surface2;
    }
  }
}

class _StatusIcon extends StatelessWidget {
  final ModelStatus status;
  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (status) {
      ModelStatus.downloaded => (Icons.check_circle_rounded, AppColors.success),
      ModelStatus.downloading => (Icons.downloading_rounded, AppColors.primary),
      ModelStatus.error => (Icons.error_rounded, AppColors.error),
      ModelStatus.notDownloaded =>
        (Icons.cloud_download_outlined, AppColors.textSecondary),
    };

    return Icon(icon, color: color, size: 28);
  }
}

class _ActionButton extends ConsumerWidget {
  final ModelInfo model;
  const _ActionButton({required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(modelControllerProvider.notifier);

    return switch (model.status) {
      ModelStatus.notDownloaded => TextButton(
          onPressed: () => controller.downloadModel(model.fileName),
          child: const Text('Download',
              style: TextStyle(color: AppColors.primary)),
        ),
      ModelStatus.downloading => TextButton(
          onPressed: null,
          child: const Text('Downloading...',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
      ModelStatus.downloaded => TextButton(
          onPressed: () => _confirmDelete(context, ref),
          child: const Text('Remove',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
      ModelStatus.error => TextButton(
          onPressed: () => controller.downloadModel(model.fileName),
          child:
              const Text('Retry', style: TextStyle(color: AppColors.error)),
        ),
    };
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Remove model?',
            style: TextStyle(color: AppColors.textPrimary)),
        content: Text(
          'You\'ll need to re-download ${model.name} to use transcription.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(modelControllerProvider.notifier)
                  .deleteModel(model.fileName);
              Navigator.pop(context);
            },
            child: const Text('Remove',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
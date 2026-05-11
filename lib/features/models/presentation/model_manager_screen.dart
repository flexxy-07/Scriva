import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/home/presentation/home_screen.dart';
import 'package:scriva/features/models/presentation/model_controller.dart';
import '../domain/model_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import 'package:google_fonts/google_fonts.dart';

part 'views/model_header_view.dart';
part 'views/model_section_view.dart';
part 'views/model_continue_button_view.dart';

class ModelManagerScreen extends ConsumerWidget {
  const ModelManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ref.watch(modelControllerProvider);
    final isReady = ref.watch(isAppReadyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI ENGINE CORE',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderView(),
              const SizedBox(height: 48),
              Expanded(child: _ModelSectionView(models: models)),
              if (isReady) ...[
                const SizedBox(height: 24),
                const _ContinueButtonView(),
              ],
              const SizedBox(height: 16),
            ],
          ),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: _statusColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusIcon(status: model.status),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toUpperCase(),
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${model.sizeMb} MB | SPEECH RECOGNITION',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (model.isDownloading) ...[
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: model.downloadProgress,
              backgroundColor: AppColors.surface2,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 2,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOWNLOADING ENGINE...',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${(model.downloadProgress * 100).toStringAsFixed(0)}%',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
          if (model.status == ModelStatus.error && model.errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              model.errorMessage!.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.error, 
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 20),
          _ActionButton(model: model),
        ],
      ),
    );
  }

  Color get _statusColor {
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
      ModelStatus.downloaded => (Icons.check, AppColors.success),
      ModelStatus.downloading => (Icons.sync, AppColors.primary),
      ModelStatus.error => (Icons.warning_amber, AppColors.error),
      ModelStatus.notDownloaded =>
        (Icons.cloud_download, AppColors.textSecondary),
    };

    return Icon(icon, color: color, size: 24);
  }
}

class _ActionButton extends ConsumerWidget {
  final ModelInfo model;
  const _ActionButton({required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(modelControllerProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: _TechnicalSubButton(
        label: switch (model.status) {
          ModelStatus.notDownloaded => 'Initialize Download',
          ModelStatus.downloading => 'Downloading...',
          ModelStatus.downloaded => 'Remove Engine',
          ModelStatus.error => 'Retry Initialization',
        },
        color: model.status == ModelStatus.error ? AppColors.error : (model.status == ModelStatus.downloaded ? AppColors.textSecondary : AppColors.primary),
        onTap: model.isDownloading ? null : () {
           if (model.status == ModelStatus.downloaded) {
             _confirmDelete(context, ref);
           } else {
             controller.downloadModel(model.fileName);
           }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: Text(
          'REMOVE ENGINE?',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        content: Text(
          'This will disable local transcription until the engine is re-initialized.',
          style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(modelControllerProvider.notifier)
                  .deleteModel(model.fileName);
              Navigator.pop(context);
            },
            child: Text(
              'CONFIRM REMOVAL',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnicalSubButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _TechnicalSubButton({
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
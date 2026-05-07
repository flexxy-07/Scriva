part of '../cleanup_screen.dart';

class _LoadingView extends ConsumerWidget {
  final CleanupState state;

  const _LoadingView({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final engine = ref.watch(settingsServiceProvider);
    final engineLabel = engine == CleanupEngine.local ? 'Running On Device' : 'Gemini Processing';
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Applying ${state.selectedMode.label}...',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Gemini is cleaning your transcript',
            style:
                TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

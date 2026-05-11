part of '../settings_screen.dart';

class _EngineSelectorTile extends ConsumerWidget {
  const _EngineSelectorTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEngine = ref.watch(settingsServiceProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surface2, width: 0.5),
      ),
      child: Row(
        children: [
          _EngineOption(
            label: 'LOCAL LLM',
            isSelected: currentEngine == CleanupEngine.local,
            onTap: () => ref
                .read(settingsServiceProvider.notifier)
                .setEngine(CleanupEngine.local),
          ),
          _EngineOption(
            label: 'GEMINI AI',
            isSelected: currentEngine == CleanupEngine.gemini,
            onTap: () => ref
                .read(settingsServiceProvider.notifier)
                .setEngine(CleanupEngine.gemini),
          ),
        ],
      ),
    );
  }
}

class _EngineOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EngineOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
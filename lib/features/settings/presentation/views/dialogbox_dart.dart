part of '../settings_screen.dart';


void _showPrivacyDialog(BuildContext context){
  showDialog(context: context, builder: (_) => AlertDialog(
    backgroundColor: AppColors.surface,
    title: const Text('Privacy First',
    style: TextStyle(

      color: AppColors.textPrimary
    ),
    ),
    content: const Text(
      'Scriva processes everything on your device.\n\n'
          '• Audio never leaves your phone\n'
          '• Transcripts stored locally only\n'
          '• No accounts or sign-in required\n'
          '• No analytics or tracking\n'
          '• AI cleanup uses Gemini API (requires internet)',
          style: TextStyle(color: AppColors.textSecondary, height: 1.6),
    ),
    actions: [
      TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it',
                style: TextStyle(color: AppColors.primary)),
          ),
    ],
  ));
}

Future<void> _confirmClearData(BuildContext context, WidgetRef ref) async {
  final confirmed = await showDialog<bool>(context: context, builder: (_) => AlertDialog(
    backgroundColor: AppColors.surface,
    title: const Text(
      'Clear all data?',
      style: TextStyle(
        color: AppColors.textPrimary
      ),
    ),
    content: const Text(
      'This will permanently delete all transcripts and recordings. This cannot be undone',
      style: TextStyle(color: AppColors.textSecondary),
    ),
    actions: [
       TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete All',
                style: TextStyle(color: AppColors.error)),
          ),
    ],
  ));

  if(confirmed == true && context.mounted){
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    // Clear all transcripts from database
    final repository = HistoryRepository();
    await repository.deleteAllTranscripts();
    
    // Refresh history state
    ref.invalidate(historyControllerProvider);
    
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All data cleared', style: TextStyle(color: AppColors.textPrimary),), backgroundColor: AppColors.surface2,)
      );
    }
  }
}
part of '../model_manager_screen.dart';

class _HeaderView extends StatelessWidget {
  const _HeaderView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: const Icon(Icons.mic_none,
                  color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              'SCRIVA',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'AI ENGINE INITIALIZATION',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'SECURE LOCAL PROCESSING REQUIRED. DOWNLOAD SYSTEM CORES TO ENABLE OFFLINE ARCHIVING AND TRANSCRIPTION.',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary,
            fontSize: 10,
            height: 1.6,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

part of '../settings_screen.dart';

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 12),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.spaceGrotesk(
          color: AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.surface2, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: titleColor ?? AppColors.primary, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      color: titleColor ?? AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }
}

class _StorageTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getStorageInfo(),
      builder: (context, snapshot) {
        final info = snapshot.data;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.surface2, width: 0.5),
          ),
          child: Row(
            children: [
              const Icon(Icons.storage,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STORAGE UTILIZATION',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      info == null
                          ? 'CALCULATING...'
                          : '${info['models']} MODELS | ${info['recordings']} RECORDINGS',
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<Map<String, dynamic>> _getStorageInfo() async {
  final appDir = await getApplicationDocumentsDirectory();
  final modelsDir = Directory(p.join(appDir.path, 'scriva_models'));
  final recordingDir = Directory(p.join(appDir.path, 'scriva_recordings'));

  int modelsSize = 0;
  int recordingsCount = 0;

  if (await modelsDir.exists()){
    await for (final f in modelsDir.list()){
      if (f is File) modelsSize += await f.length();
    }
  }

  if (await recordingDir.exists()){
    await for (final f in recordingDir.list()){
      if (f is File) recordingsCount++;
    }
  }

  final mb = (modelsSize / (1024 * 1024)).toStringAsFixed(0);
  return {
    'models': '${mb}MB',
    'recordings': '$recordingsCount',
  };
}

class _VersionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(), 
      builder: (context, snapshot){
        final version = snapshot.data?.version ?? '';
        final build = snapshot.data?.buildNumber ?? '';
        return Container(
          margin: const EdgeInsets.only(bottom: 1),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.surface2, width: 0.5),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline,
              color: AppColors.primary, size: 20,
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SCRIVA CORE',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'VERSION $version (BUILD $build)',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }
    );
  }
}

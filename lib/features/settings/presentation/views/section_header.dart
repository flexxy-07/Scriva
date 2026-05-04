part of '../settings_screen.dart';

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
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
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: titleColor ?? AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textSecondary, size: 18),
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
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.storage_rounded,
                  color: AppColors.primary, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Storage Used',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      info == null
                          ? 'Calculating...'
                          : '${info['models']} models · ${info['recordings']} recordings',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
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

  final modelsDir = Directory(
    p.join(appDir.path, 'scriva_models')
  );

  final recordingDir = Directory(
    p.join(appDir.path, 'scriva_recordings')
  );

  int modelsSize = 0;
  int recordingsCount = 0;

  if (await modelsDir.exists()){
    await for (final f in modelsDir.list()){
      if (f is File) modelsSize += await f.length();
    }
  }

  final mb = (modelsSize / (1024 * 1024)).toStringAsFixed(0);
    return {
      'models': '${mb}MB',
      'recordings': '$recordingsCount files',
    };
}

class _VersionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return FutureBuilder<PackageInfo>(future: PackageInfo.fromPlatform(), builder: (context, snapshot){
      final version = snapshot.data?.version ?? '';
      final build = snapshot.data?.buildNumber ?? '';
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14)
        ),

        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
            color: AppColors.primary, size: 22,
            ),
            const SizedBox(width: 14,),
            Column(
              crossAxisAlignment: CrossAxisAlignment
              .start,
              children: [
                const Text(
                  'Scriva',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Version $version ($build)',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}

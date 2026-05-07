import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scriva/core/services/settings_service.dart';
import 'package:scriva/features/models/presentation/model_manager_screen.dart';
import 'package:scriva/features/onboarding/presentation/onboarding_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scriva/features/history/data/history_repository.dart';
import 'package:scriva/features/history/presentation/history_controller.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part './views/dialogbox_dart.dart';
part './views/section_header.dart';
part './views/engine_selector.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionHeader(label: 'CLEANUP ENGINE'),
            _EngineSelectorTile(),
            _SettingsTile(
              icon: Icons.memory_rounded,
              title: 'Manage Models',
              subtitle: 'Download or remove AI Models',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ModelManagerScreen()),
              ),
            ),
            const SizedBox(height: 24),

            // storage
            _SectionHeader(label: 'Storage'),
            _StorageTile(),

            const SizedBox(height: 24),

            //about
            _SectionHeader(label: 'ABOUT'),
            _VersionTile(),
            _SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              subtitle: 'All data stays on your device',
              onTap: () => _showPrivacyDialog(context),
            ),

            _SettingsTile(
              icon: Icons.replay_rounded,
              title: 'Replay Onboarding',
              subtitle: 'See the intro screens again',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              ),
            ),
            const SizedBox(height: 24),

            // Danger zone
            _SectionHeader(label: 'DANGER ZONE'),
            _SettingsTile(
              icon: Icons.delete_forever_rounded,
              title: 'Clear All Data',
              subtitle: 'Delete all transcripts and recordings',
              titleColor: AppColors.error,
              onTap: () => _confirmClearData(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}

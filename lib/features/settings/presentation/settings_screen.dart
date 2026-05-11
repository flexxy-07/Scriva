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
import 'package:google_fonts/google_fonts.dart';

part './views/dialogbox_dart.dart';
part './views/section_header.dart';
part './views/engine_selector.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONFIGURATION',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const _SectionHeader(label: 'CLEANUP ENGINE'),
            const _EngineSelectorTile(),
            _SettingsTile(
              icon: Icons.memory,
              title: 'Manage Models',
              subtitle: 'Download or remove AI Models',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ModelManagerScreen()),
              ),
            ),
            const SizedBox(height: 32),

            const _SectionHeader(label: 'STORAGE'),
            _StorageTile(),

            const SizedBox(height: 32),

            const _SectionHeader(label: 'ABOUT'),
            _VersionTile(),
            _SettingsTile(
              icon: Icons.privacy_tip,
              title: 'Privacy',
              subtitle: 'All data stays on your device',
              onTap: () => _showPrivacyDialog(context),
            ),
            _SettingsTile(
              icon: Icons.replay,
              title: 'Replay Onboarding',
              subtitle: 'See the intro screens again',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              ),
            ),
            const SizedBox(height: 32),

            const _SectionHeader(label: 'DANGER ZONE'),
            _SettingsTile(
              icon: Icons.delete_forever,
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

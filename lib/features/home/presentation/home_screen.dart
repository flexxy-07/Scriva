import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/history/presentation/history_screen.dart';
import 'package:scriva/features/recording/presentation/recording_screen.dart';
import 'package:scriva/features/settings/presentation/settings_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final _screens = const [RecordingScreen(), HistoryScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildTechnicalNavBar(),
    );
  }

  Widget _buildTechnicalNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.surface2, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TechnicalNavItem(
              icon: Icons.mic_none,
              label: 'RECORD',
              isSelected: _selectedIndex == 0,
              onTap: () => setState(() => _selectedIndex = 0),
            ),
            _TechnicalNavItem(
              icon: Icons.history,
              label: 'HISTORY',
              isSelected: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            _TechnicalNavItem(
              icon: Icons.settings,
              label: 'SETTINGS',
              isSelected: _selectedIndex == 2,
              onTap: () => setState(() => _selectedIndex = 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechnicalNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TechnicalNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
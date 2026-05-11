import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/models/presentation/model_manager_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:scriva/shared/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

part './onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = const [
    _OnboardingPage(
      emoji: '🎙️',
      title: 'RECORDING MODULE',
      subtitle:
          'MEETINGS, LECTURES, IDEAS, INTERVIEWS.\nSCRIVA CAPTURES EVERY WORD LOCALLY.',
    ),
    _OnboardingPage(
      emoji: '🔒',
      title: 'SECURE LOCAL ARCHIVE',
      subtitle:
          'NO CLOUD. NO UPLOADS. NO SUBSCRIPTIONS.\nYOUR VOICE NEVER LEAVES THIS DEVICE.',
    ),
    _OnboardingPage(
      emoji: '✨',
      title: 'AI CLEANUP ENGINE',
      subtitle:
          'TRANSFORM MESSY SPEECH INTO CLEAN NOTES,\nMEETING SUMMARIES, OR BULLET POINTS.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _complete,
                child: Text(
                  'SKIP MODULE',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            // pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: _pages,
              ),
            ),

            // technical dots (rectangles)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 32 : 12,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentPage == i ? AppColors.primary : AppColors.surface2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: AppButton(
                label: _currentPage == _pages.length - 1 ? 'INITIALIZE SYSTEM' : 'NEXT MODULE',
                icon: _currentPage == _pages.length - 1 ? Icons.power_settings_new : Icons.arrow_forward,
                onTap: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                    );
                  } else {
                    _complete();
                  }
                },
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ModelManagerScreen()),
      );
    }
  }
}
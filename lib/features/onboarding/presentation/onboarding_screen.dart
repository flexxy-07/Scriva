import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/models/presentation/model_manager_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:scriva/shared/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


part './onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = const [
    _OnboardingPage(
      emoji: '🎙️',
      title: 'Record anything',
      subtitle:
          'Meetings, lectures, ideas, interviews.\nScriva captures every word.',
    ),
    _OnboardingPage(
      emoji: '🔒',
      title: 'Stays on your device',
      subtitle:
          'No cloud. No uploads. No subscriptions.\nYour voice never leaves your phone.',
    ),
    _OnboardingPage(
      emoji: '✨',
      title: 'AI cleans it up',
      subtitle:
          'Transform messy speech into clean notes,\nmeeting summaries, or bullet points.',
    ),

  ];


  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: _complete, child: const Text(
              'Skip', style: TextStyle(
                color: AppColors.textSecondary
              ),
            )),
          ),
          // pages
          Expanded(child: PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            children: _pages,
          )),

          // dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (i) => AnimatedContainer(duration: const Duration(microseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == i ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == i ? AppColors.primary : AppColors.surface2, borderRadius: BorderRadius.circular(4)
            ),
            )),
          ),
          const SizedBox(height: 32,),

          Padding(padding: const EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(label: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
            icon: _currentPage == _pages.length - 1 ? Icons.check_rounded : Icons.arrow_forward_rounded,
            onTap: () {
              if(_currentPage < _pages.length - 1){
                _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }else{
                _complete();
              }
            },
            ),
          ),
          ),
           const SizedBox(height: 32,),
        ],
      ),),
    );
  }

Future<void> _complete() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_complete', true);
  if(mounted){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ModelManagerScreen())
    );
  }
}
}
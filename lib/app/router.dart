import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static const String onBoarding = '/onboarding';
  static const String modelSetup = '/model-setup';
  static const String home = '/home';
}

final initialRouteProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('onboarding_complete') ?? false;
  final hasModel = prefs.getBool('whisper_model_ready') ?? false;
  if(!hasSeenOnboarding) return AppRouter.onBoarding;
  if(!hasModel) return AppRouter.modelSetup;
  return AppRouter.home;
});
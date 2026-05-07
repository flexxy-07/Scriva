import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CleanupEngine {gemini, local}

class SettingsService extends StateNotifier<CleanupEngine> {
  SettingsService(): super(CleanupEngine.gemini){
    _load();
  }

  static const _key = 'cleanup_engine';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    state = value == 'local' ? CleanupEngine.local : CleanupEngine.gemini;
  }

  Future<void> setEngine(CleanupEngine engine) async {
    state = engine;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, engine == CleanupEngine.local ? 'local' : 'gemini');
  }
}

final settingsServiceProvider = StateNotifierProvider<SettingsService, CleanupEngine>(
  (ref) => SettingsService()
);
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/translations.dart';

class LocalizationProvider extends ChangeNotifier {
  String _currentLang;
  final String _langKey = 'selected_language';

  LocalizationProvider(this._currentLang) {
    if (_currentLang == 'en') {
      _setDefaultIfNeeded();
    }
  }

  String get currentLang => _currentLang;

  Future<void> _setDefaultIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_langKey)) {
      await prefs.setString(_langKey, 'en');
    }
  }

  Future<void> toggleLanguage() async {
    final List<String> supportedLangs = ['vi', 'en', 'es', 'zh'];
    int currentIndex = supportedLangs.indexOf(_currentLang);
    int nextIndex = (currentIndex + 1) % supportedLangs.length;
    _currentLang = supportedLangs[nextIndex];

    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, _currentLang);
  }

  Future<void> setLanguage(String lang) async {
    final List<String> supportedLangs = ['vi', 'en', 'es', 'zh'];
    if (supportedLangs.contains(lang)) {
      _currentLang = lang;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_langKey, _currentLang);
    }
  }

  String translate(String key) {
    return AppTranslations.translations[_currentLang]?[key] ?? key;
  }
}

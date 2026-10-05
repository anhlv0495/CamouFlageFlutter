import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  // Singleton pattern
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Logs a custom event
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
      debugPrint('Analytics Event Logged: $name, parameters: $parameters');
    } catch (e) {
      debugPrint('Failed to log event $name: $e');
    }
  }

  /// Sets the current screen name
  Future<void> setCurrentScreen(String screenName, {String screenClassOverride = 'Flutter'}) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClassOverride,
      );
      debugPrint('Analytics Screen Set: $screenName');
    } catch (e) {
      debugPrint('Failed to set screen $screenName: $e');
    }
  }

  /// Sets user properties
  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
      debugPrint('Analytics User Property Set: $name = $value');
    } catch (e) {
      debugPrint('Failed to set user property $name: $e');
    }
  }
}

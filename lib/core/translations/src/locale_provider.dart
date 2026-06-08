import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
// Key for SharedPreferences
// ─────────────────────────────────────────────
const _kLocaleKey = 'app_locale';

// ─────────────────────────────────────────────
// Supported locales
// ─────────────────────────────────────────────
const List<Locale> kSupportedLocales = [
  Locale('en'),
  Locale('ar'),
];

const Locale kDefaultLocale = Locale('en');

// ─────────────────────────────────────────────
// SharedPreferences provider (override in main)
// ─────────────────────────────────────────────
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Override sharedPreferencesProvider in ProviderScope:\n\n'
    'overrides: [\n'
    '  sharedPreferencesProvider.overrideWithValue(prefs),\n'
    ']',
  );
});

// ─────────────────────────────────────────────
// Locale Notifier
// ─────────────────────────────────────────────
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getString(_kLocaleKey);

    if (saved != null) {
      final locale = Locale(saved);
      if (kSupportedLocales.contains(locale)) return locale;
    }
    return kDefaultLocale;
  }

  /// Change app locale and persist it
  Future<void> setLocale(Locale locale) async {
    if (!kSupportedLocales.contains(locale)) return;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_kLocaleKey, locale.languageCode);
    state = locale;
  }

  /// Toggle between Arabic and English
  Future<void> toggle() async {
    final next = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    await setLocale(next);
  }

  bool get isArabic => state.languageCode == 'ar';
  bool get isRTL => state.languageCode == 'ar' || state.languageCode == 'he' || state.languageCode == 'fa';
}

// ─────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Storage Key ──────────────────────────────────────────────────────────────
const _kThemeKey = 'app_theme_mode';

// ─── ThemeMode Notifier ───────────────────────────────────────────────────────

/// يحفظ الثيم في SharedPreferences ويعيد تحميله عند فتح التطبيق
class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeKey);
    return _fromString(saved);
  }

  /// تبديل بين الثيمات الثلاثة: system → light → dark → system
  Future<void> toggle() async {
    final current = state.valueOrNull ?? ThemeMode.system;
    final next = switch (current) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    await _save(next);
  }

  /// ضبط ثيم محدد مباشرة
  Future<void> setTheme(ThemeMode mode) async => _save(mode);

  Future<void> _save(ThemeMode mode) async {
    state = AsyncData(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeKey, _toString(mode));
  }

  static ThemeMode _fromString(String? v) => switch (v) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  static String _toString(ThemeMode m) => switch (m) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}

// ─── Providers ────────────────────────────────────────────────────────────────

/// Provider الرئيسي لـ ThemeMode — استخدمه في MaterialApp
final themeModeProvider = AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Provider مساعد يعطيك ThemeMode جاهزاً (system كقيمة افتراضية أثناء التحميل)
final resolvedThemeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
});

/// هل الوضع الحالي dark؟ (يأخذ في الاعتبار system theme)
final isDarkModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(resolvedThemeModeProvider);
  if (mode == ThemeMode.system) {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
  return mode == ThemeMode.dark;
});

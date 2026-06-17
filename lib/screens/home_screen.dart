import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/theme_provider.dart';
import 'package:flutter_core/core/translations/src/locale_provider.dart';
import 'package:flutter_core/core/translations/src/localization_extension.dart';
import 'package:flutter_core/core/widgets/language_dialog.dart';
import 'package:flutter_core/core/widgets/theme_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.tr;
    final themeMode = ref.watch(resolvedThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        actions: [
          // تغيير اللغة
          IconButton(
            tooltip: tr.language,
            icon: const Icon(Icons.language_rounded),
            onPressed: () {
              LanguageDialog.show(context, ref, ref.read(localeProvider));
            },
          ),
          // تغيير الثيم
          IconButton(
            tooltip: tr.theme,
            icon: Icon(_themeIcon(themeMode)),
            onPressed: () => ThemeDialog.show(context, ref, themeMode),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            tr.itemCount(5),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
    ThemeMode.light => Icons.light_mode_rounded,
    ThemeMode.dark => Icons.dark_mode_rounded,
    ThemeMode.system => Icons.brightness_auto_rounded,
  };
}

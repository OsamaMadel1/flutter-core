import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme.dart';
import 'core/translations/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const FlutterCoreApp(),
    ),
  );
}

class FlutterCoreApp extends ConsumerWidget {
  const FlutterCoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(resolvedThemeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends ConsumerWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.tr;
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(resolvedThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appName),
        actions: [
          IconButton(
            tooltip: tr.language,
            icon: const Icon(Icons.language_rounded),
            onPressed: () => ref.read(localeProvider.notifier).toggle(),
          ),
          IconButton(
            tooltip: tr.theme,
            icon: Icon(_themeIcon(themeMode)),
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              tr.welcomeBack('Osama'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              tr.lastUpdated(DateTime.now().year.toString()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _SettingsGroup(
              title: tr.language,
              child: _LocaleChips(currentLocale: locale),
            ),
            const SizedBox(height: 20),
            _SettingsGroup(
              title: tr.theme,
              child: _ThemeModeChips(currentMode: themeMode),
            ),
            const SizedBox(height: 24),
            const _PreviewPanel(),
          ],
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

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _LocaleChips extends ConsumerWidget {
  const _LocaleChips({required this.currentLocale});

  final Locale currentLocale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [Locale('en'), Locale('ar')].map((locale) {
        final selected = locale == currentLocale;

        return ChoiceChip(
          label: Text(locale.languageCode.toUpperCase()),
          selected: selected,
          onSelected: (_) {
            if (!selected) {
              ref.read(localeProvider.notifier).setLocale(locale);
            }
          },
        );
      }).toList(),
    );
  }
}

class _ThemeModeChips extends ConsumerWidget {
  const _ThemeModeChips({required this.currentMode});

  final ThemeMode currentMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.tr;

    final options = <ThemeMode, String>{
      ThemeMode.system: tr.systemTheme,
      ThemeMode.light: tr.lightMode,
      ThemeMode.dark: tr.darkMode,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.entries.map((entry) {
        final selected = entry.key == currentMode;

        return ChoiceChip(
          label: Text(entry.value),
          selected: selected,
          onSelected: (_) {
            if (!selected) {
              ref.read(themeModeProvider.notifier).setTheme(entry.key);
            }
          },
        );
      }).toList(),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel();

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(tr.settings, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(tr.itemCount(5)),
            const SizedBox(height: 8),
            Text(tr.notificationsCount(2)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_rounded),
              label: Text(tr.continueText),
            ),
          ],
        ),
      ),
    );
  }
}

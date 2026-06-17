import 'package:flutter/material.dart';
import 'package:flutter_core/core/translations/src/locale_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageDialog {
  static void show(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Language'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tile(
                ref: ref,
                dialogContext: dialogContext,
                locale: const Locale('ar'),
                current: currentLocale,
                title: 'العربية',
                icon: Icons.language,
              ),
              _tile(
                ref: ref,
                dialogContext: dialogContext,
                locale: const Locale('en'),
                current: currentLocale,
                title: 'English',
                icon: Icons.language,
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _tile({
    required WidgetRef ref,
    required BuildContext dialogContext,
    required Locale locale,
    required Locale current,
    required String title,
    required IconData icon,
  }) {
    final selected = locale.languageCode == current.languageCode;

    return ListTile(
      leading: Icon(
        selected ? Icons.check_circle : icon,
      ),
      title: Text(title),
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(locale);
        Navigator.pop(dialogContext);
      },
    );
  }
}
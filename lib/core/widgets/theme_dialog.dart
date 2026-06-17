import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeDialog {
  static void show(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Theme'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tile(
                context: context,
                ref: ref,
                dialogContext: dialogContext,
                mode: ThemeMode.system,
                current: currentMode,
                title: 'System',
                icon: Icons.brightness_auto_rounded,
              ),
              _tile(
                context: context,
                ref: ref,
                dialogContext: dialogContext,
                mode: ThemeMode.light,
                current: currentMode,
                title: 'Light',
                icon: Icons.light_mode_rounded,
              ),
              _tile(
                context: context,
                ref: ref,
                dialogContext: dialogContext,
                mode: ThemeMode.dark,
                current: currentMode,
                title: 'Dark',
                icon: Icons.dark_mode_rounded,
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _tile({
    required BuildContext context,
    required WidgetRef ref,
    required BuildContext dialogContext,
    required ThemeMode mode,
    required ThemeMode current,
    required String title,
    required IconData icon,
  }) {
    final selected = mode == current;

    return ListTile(
      leading: Icon(selected ? Icons.check_circle : icon),
      title: Text(title),
      onTap: () {
        ref.read(themeModeProvider.notifier).setTheme(mode);
        Navigator.pop(dialogContext);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart';

/// 🌓 زر تبديل الثيم — ضعه في أي مكان في تطبيقك
///
/// مثال الاستخدام في AppBar:
/// ```dart
/// AppBar(actions: [ThemeToggleButton()])
/// ```
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(resolvedThemeModeProvider);

    return IconButton(
      tooltip: _tooltip(mode),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(_icon(mode), key: ValueKey(mode)),
      ),
      onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
    );
  }

  IconData _icon(ThemeMode mode) => switch (mode) {
    ThemeMode.light => Icons.light_mode_rounded,
    ThemeMode.dark => Icons.dark_mode_rounded,
    ThemeMode.system => Icons.brightness_auto_rounded,
  };

  String _tooltip(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'وضع نهاري',
    ThemeMode.dark => 'وضع ليلي',
    ThemeMode.system => 'تلقائي (النظام)',
  };
}

/// 🎛️ قائمة اختيار الثيم — مناسبة لصفحة الإعدادات
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(resolvedThemeModeProvider);
    final scheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مظهر التطبيق', style: tt.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: ThemeMode.values.map((mode) {
            final selected = mode == current;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? scheme.primary : scheme.outline,
                      width: selected ? 2 : 1,
                    ),
                    color: selected
                        ? scheme.primary.withOpacity(0.1)
                        : scheme.surface,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).setTheme(mode),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _icon(mode),
                            color: selected
                                ? scheme.primary
                                : scheme.onSurfaceVariant,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _label(mode),
                            style: tt.labelSmall?.copyWith(
                              color: selected
                                  ? scheme.primary
                                  : scheme.onSurfaceVariant,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _icon(ThemeMode m) => switch (m) {
    ThemeMode.light => Icons.light_mode_rounded,
    ThemeMode.dark => Icons.dark_mode_rounded,
    ThemeMode.system => Icons.brightness_auto_rounded,
  };

  String _label(ThemeMode m) => switch (m) {
    ThemeMode.light => 'فاتح',
    ThemeMode.dark => 'داكن',
    ThemeMode.system => 'تلقائي',
  };
}

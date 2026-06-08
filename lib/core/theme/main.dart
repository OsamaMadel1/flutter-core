import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';

void main() {
  runApp(
    // ✅ ProviderScope مطلوب لـ Riverpod
    const ProviderScope(child: MyApp()),
  );
}
 
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ استمع لـ ThemeMode من الـ Provider
    final themeMode = ref.watch(resolvedThemeModeProvider);

    return MaterialApp(
      title: 'Blue Theme App',
      debugShowCheckedModeBanner: false,

      // ── الثيمات ──────────────────────────────────
      theme:      AppTheme.light,   // ثيم الوضع الفاتح
      darkTheme:  AppTheme.dark,    // ثيم الوضع الداكن
      themeMode:  themeMode,        // التحكم من Riverpod

      home: const _DemoScreen(),
    );
  }
}

// ─── شاشة تجريبية لعرض الثيمات ───────────────────────────────────────────────
class _DemoScreen extends ConsumerWidget {
  const _DemoScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue Theme System'),
        actions: const [ThemeToggleButton()], // ✅ زر التبديل
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Buttons ──────────────────────────────
          _Section(title: 'Buttons', children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('TextButton'),
            ),
          ]),

          // ── TextField ────────────────────────────
          _Section(title: 'TextField', children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                hintText: 'example@mail.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
          ]),

          // ── Cards ─────────────────────────────────
          _Section(title: 'Cards', children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Title', style: tt.titleMedium),
                    const SizedBox(height: 6),
                    Text(
                      'هذا مثال على محتوى البطاقة مع الثيم الأزرق.',
                      style: tt.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ]),

          // ── Colors ────────────────────────────────
          _Section(title: 'Color Palette', children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ColorChip('Primary', cs.primary),
                _ColorChip('Secondary', cs.secondary),
                _ColorChip('Surface', cs.surface, border: true),
                _ColorChip('Error', cs.error),
                _ColorChip('Success', AppColors.success),
                _ColorChip('Warning', AppColors.warning),
              ],
            ),
          ]),

          // ── Progress ──────────────────────────────
          _Section(title: 'Progress', children: [
            const LinearProgressIndicator(value: 0.65),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(context),
              child: Slider(value: 0.65, onChanged: (_) {}),
            ),
          ]),

          // ── Chips ─────────────────────────────────
          _Section(title: 'Chips', children: [
            Wrap(
              spacing: 8,
              children: [
                Chip(label: const Text('Flutter')),
                Chip(label: const Text('Riverpod')),
                Chip(label: const Text('Blue Theme')),
              ],
            ),
          ]),

          // ── Theme Selector ────────────────────────
          _Section(
            title: 'تغيير الثيم',
            children: const [ThemeSelector()],
          ),

          const SizedBox(height: 32),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  )),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool border;
  const _ColorChip(this.label, this.color, {this.border = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: border
                ? Border.all(
                    color: Theme.of(context).colorScheme.outline, width: 1)
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center),
      ],
    );
  }
}

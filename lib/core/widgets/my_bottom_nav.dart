import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyBottomNav — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: BottomNavigationBar + NavigationBar
//  Import: import 'core/widgets/my_bottom_nav.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyNavStyle {
  classic, // أيقونة + نص دائماً ← default
  floating, // عائم مع خلفية مستطيلة
  pill, // الـ active item داخل pill
  minimal, // نص فقط عند الـ active
  dot, // نقطة صغيرة تحت الأيقونة النشطة
}

// ─────────────────────────────────────────
//  NAV ITEM MODEL
// ─────────────────────────────────────────

class MyNavItem {
  final IconData icon;
  final IconData? activeIcon; // أيقونة مختلفة عند التفعيل
  final String label;
  final int? badgeCount; // رقم الإشعارات
  final bool showBadgeDot; // نقطة إشعار بدون رقم

  const MyNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeCount,
    this.showBadgeDot = false,
  });
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyBottomNav extends StatelessWidget {
  final List<MyNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final MyNavStyle style;

  // ── تخصيص اختياري ──
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final double? elevation;
  final double? iconSize;
  final double? fontSize;
  final bool showLabels;
  final bool enableHaptic;
  final EdgeInsetsGeometry? floatingMargin; // للـ floating style

  const MyBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.style = MyNavStyle.classic,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.elevation,
    this.iconSize = 24,
    this.fontSize = 11,
    this.showLabels = true,
    this.enableHaptic = true,
    this.floatingMargin,
  }) : assert(
         items.length >= 2 && items.length <= 5,
         'MyBottomNav: يجب أن يكون عدد العناصر بين 2 و 5',
       );

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MyNavStyle.floating:
        return _FloatingNav(nav: this);
      case MyNavStyle.pill:
        return _PillNav(nav: this);
      case MyNavStyle.minimal:
        return _MinimalNav(nav: this);
      case MyNavStyle.dot:
        return _DotNav(nav: this);
      case MyNavStyle.classic:
        return _ClassicNav(nav: this);
    }
  }
}

// ─────────────────────────────────────────
//  BADGE HELPER
// ─────────────────────────────────────────

class _NavBadge extends StatelessWidget {
  final MyNavItem item;
  final Widget child;

  const _NavBadge({required this.item, required this.child});

  @override
  Widget build(BuildContext context) {
    if (item.badgeCount == null && !item.showBadgeDot) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -4,
          right: -6,
          child: Container(
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            padding: item.badgeCount != null
                ? const EdgeInsets.symmetric(horizontal: 4)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 1.5,
              ),
            ),
            child: item.badgeCount != null
                ? Center(
                    child: Text(
                      item.badgeCount! > 99 ? '99+' : '${item.badgeCount}',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  )
                : const SizedBox(width: 6, height: 6),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
//  CLASSIC NAV
// ─────────────────────────────────────────

class _ClassicNav extends StatelessWidget {
  final MyBottomNav nav;
  const _ClassicNav({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = nav.activeColor ?? theme.colorScheme.primary;
    final inactive =
        nav.inactiveColor ?? (isDark ? Colors.white38 : Colors.black38);
    final bg =
        nav.backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: nav.elevation ?? 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: nav.items.asMap().entries.map((e) {
              final isActive = e.key == nav.currentIndex;
              final icon = isActive
                  ? (e.value.activeIcon ?? e.value.icon)
                  : e.value.icon;

              return Expanded(
                child: _NavTapArea(
                  onTap: () => _tap(context, e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _NavBadge(
                          item: e.value,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              icon,
                              key: ValueKey(isActive),
                              size: nav.iconSize,
                              color: isActive ? active : inactive,
                            ),
                          ),
                        ),
                        if (nav.showLabels) ...[
                          const SizedBox(height: 4),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: nav.fontSize,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isActive ? active : inactive,
                            ),
                            child: Text(e.value.label),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _tap(BuildContext ctx, int i) {
    if (nav.enableHaptic) HapticFeedback.lightImpact();
    nav.onTap(i);
  }
}

// ─────────────────────────────────────────
//  FLOATING NAV
// ─────────────────────────────────────────

class _FloatingNav extends StatelessWidget {
  final MyBottomNav nav;
  const _FloatingNav({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = nav.activeColor ?? theme.colorScheme.primary;
    final inactive =
        nav.inactiveColor ?? (isDark ? Colors.white54 : Colors.black45);
    final bg =
        nav.backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    return Padding(
      padding: nav.floatingMargin ?? const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: active.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: nav.items.asMap().entries.map((e) {
            final isActive = e.key == nav.currentIndex;
            final icon = isActive
                ? (e.value.activeIcon ?? e.value.icon)
                : e.value.icon;

            return Expanded(
              child: _NavTapArea(
                onTap: () {
                  if (nav.enableHaptic) HapticFeedback.lightImpact();
                  nav.onTap(e.key);
                },
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _NavBadge(
                      item: e.value,
                      child: Icon(
                        icon,
                        size: nav.iconSize,
                        color: isActive ? active : inactive,
                      ),
                    ),
                    if (nav.showLabels && isActive) ...[
                      const SizedBox(height: 3),
                      Text(
                        e.value.label,
                        style: TextStyle(
                          fontSize: nav.fontSize,
                          fontWeight: FontWeight.w700,
                          color: active,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  PILL NAV
// ─────────────────────────────────────────

class _PillNav extends StatelessWidget {
  final MyBottomNav nav;
  const _PillNav({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = nav.activeColor ?? theme.colorScheme.primary;
    final inactive =
        nav.inactiveColor ?? (isDark ? Colors.white38 : Colors.black38);
    final bg =
        nav.backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    return Container(
      color: bg,
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            children: nav.items.asMap().entries.map((e) {
              final isActive = e.key == nav.currentIndex;
              final icon = isActive
                  ? (e.value.activeIcon ?? e.value.icon)
                  : e.value.icon;

              return Expanded(
                child: _NavTapArea(
                  onTap: () {
                    if (nav.enableHaptic) HapticFeedback.lightImpact();
                    nav.onTap(e.key);
                  },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: isActive
                          ? const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            )
                          : const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? active.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _NavBadge(
                            item: e.value,
                            child: Icon(
                              icon,
                              size: nav.iconSize,
                              color: isActive ? active : inactive,
                            ),
                          ),
                          if (isActive && nav.showLabels) ...[
                            const SizedBox(width: 6),
                            Text(
                              e.value.label,
                              style: TextStyle(
                                fontSize: nav.fontSize! + 1,
                                fontWeight: FontWeight.w700,
                                color: active,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  MINIMAL NAV
// ─────────────────────────────────────────

class _MinimalNav extends StatelessWidget {
  final MyBottomNav nav;
  const _MinimalNav({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = nav.activeColor ?? theme.colorScheme.primary;
    final inactive =
        nav.inactiveColor ?? (isDark ? Colors.white38 : Colors.black38);
    final bg =
        nav.backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    return Container(
      color: bg,
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: nav.items.asMap().entries.map((e) {
              final isActive = e.key == nav.currentIndex;
              final icon = isActive
                  ? (e.value.activeIcon ?? e.value.icon)
                  : e.value.icon;

              return Expanded(
                child: _NavTapArea(
                  onTap: () {
                    if (nav.enableHaptic) HapticFeedback.lightImpact();
                    nav.onTap(e.key);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _NavBadge(
                        item: e.value,
                        child: Icon(
                          icon,
                          size: nav.iconSize,
                          color: isActive ? active : inactive,
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: isActive
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  e.value.label,
                                  style: TextStyle(
                                    fontSize: nav.fontSize,
                                    fontWeight: FontWeight.w700,
                                    color: active,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  DOT NAV
// ─────────────────────────────────────────

class _DotNav extends StatelessWidget {
  final MyBottomNav nav;
  const _DotNav({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = nav.activeColor ?? theme.colorScheme.primary;
    final inactive =
        nav.inactiveColor ?? (isDark ? Colors.white38 : Colors.black38);
    final bg =
        nav.backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    return Container(
      color: bg,
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: nav.items.asMap().entries.map((e) {
              final isActive = e.key == nav.currentIndex;
              final icon = isActive
                  ? (e.value.activeIcon ?? e.value.icon)
                  : e.value.icon;

              return Expanded(
                child: _NavTapArea(
                  onTap: () {
                    if (nav.enableHaptic) HapticFeedback.lightImpact();
                    nav.onTap(e.key);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _NavBadge(
                        item: e.value,
                        child: Icon(
                          icon,
                          size: nav.iconSize,
                          color: isActive ? active : inactive,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        width: isActive ? 20 : 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive ? active : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  TAP AREA HELPER
// ─────────────────────────────────────────

class _NavTapArea extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final BorderRadius? borderRadius;

  const _NavTapArea({
    required this.onTap,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      highlightColor: Colors.transparent,
      child: SizedBox(height: double.infinity, child: child),
    );
  }
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  الاستخدام الأساسي مع StatefulWidget
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

int _currentIndex = 0;

Scaffold(
  body: _pages[_currentIndex],
  bottomNavigationBar: MyBottomNav(
    currentIndex: _currentIndex,
    onTap: (i) => setState(() => _currentIndex = i),
    items: const [
      MyNavItem(icon: Icons.home_outlined,    activeIcon: Icons.home_rounded,    label: 'الرئيسية'),
      MyNavItem(icon: Icons.search_outlined,   activeIcon: Icons.search_rounded,  label: 'بحث'),
      MyNavItem(icon: Icons.favorite_outline,  activeIcon: Icons.favorite_rounded, label: 'المفضلة'),
      MyNavItem(icon: Icons.person_outline,    activeIcon: Icons.person_rounded,  label: 'حسابي'),
    ],
  ),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STYLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyBottomNav(style: MyNavStyle.classic,  ...)   // ← default
MyBottomNav(style: MyNavStyle.floating, ...)   // عائم مع shadow
MyBottomNav(style: MyNavStyle.pill,     ...)   // active داخل pill
MyBottomNav(style: MyNavStyle.minimal,  ...)   // نص عند active فقط
MyBottomNav(style: MyNavStyle.dot,      ...)   // شريط صغير تحت الأيقونة

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BADGES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyNavItem(
  icon: Icons.notifications_outlined,
  activeIcon: Icons.notifications_rounded,
  label: 'الإشعارات',
  badgeCount: 5,         // رقم
)

MyNavItem(
  icon: Icons.message_outlined,
  label: 'الرسائل',
  showBadgeDot: true,    // نقطة فقط
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مع Riverpod
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final navIndexProvider = StateProvider<int>((ref) => 0);

// في الـ Widget
final index = ref.watch(navIndexProvider);

MyBottomNav(
  currentIndex: index,
  onTap: (i) => ref.read(navIndexProvider.notifier).state = i,
  items: [...],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Floating مع هامش مخصص
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyBottomNav(
  style: MyNavStyle.floating,
  floatingMargin: EdgeInsets.fromLTRB(24, 0, 24, 24),
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: [...],
)

*/

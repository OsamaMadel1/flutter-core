import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyTabBar — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: TabBar + TabBarView + DefaultTabController
//  Import: import 'core/widgets/my_tab_bar.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyTabStyle {
  underline, // خط تحت التاب النشط ← default
  pill, // التاب النشط داخل pill
  segmented, // كل التابات داخل container واحد (iOS style)
  boxed, // كل تاب صندوق منفصل
}

// ─────────────────────────────────────────
//  TAB ITEM MODEL
// ─────────────────────────────────────────

class MyTabItem {
  final String label;
  final IconData? icon;
  final int? badgeCount;
  final bool showBadgeDot;

  const MyTabItem({
    required this.label,
    this.icon,
    this.badgeCount,
    this.showBadgeDot = false,
  });
}

// ─────────────────────────────────────────
//  MAIN WIDGET — MyTabBar
// ─────────────────────────────────────────

class MyTabBar extends StatefulWidget {
  final List<MyTabItem> tabs;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final MyTabStyle style;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final bool isScrollable;
  final bool enableHaptic;
  final TabController? controller;

  const MyTabBar({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onChanged,
    this.style = MyTabStyle.underline,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.isScrollable = false,
    this.enableHaptic = true,
    this.controller,
  });

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController _ctrl;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl =
        widget.controller ??
        TabController(
          length: widget.tabs.length,
          vsync: this,
          initialIndex: widget.initialIndex,
        );
    _ctrl.addListener(() {
      if (_ctrl.indexIsChanging || _ctrl.index != _current) {
        setState(() => _current = _ctrl.index);
        if (widget.enableHaptic) HapticFeedback.selectionClick();
        widget.onChanged?.call(_ctrl.index);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  void _select(int i) {
    if (widget.enableHaptic) HapticFeedback.selectionClick();
    setState(() => _current = i);
    _ctrl.animateTo(i);
    widget.onChanged?.call(i);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case MyTabStyle.pill:
        return _PillTabBar(state: this);
      case MyTabStyle.segmented:
        return _SegmentedTabBar(state: this);
      case MyTabStyle.boxed:
        return _BoxedTabBar(state: this);
      case MyTabStyle.underline:
        return _UnderlineTabBar(state: this);
    }
  }
}

// ─────────────────────────────────────────
//  UNDERLINE STYLE
// ─────────────────────────────────────────

class _UnderlineTabBar extends StatelessWidget {
  final _MyTabBarState state;
  const _UnderlineTabBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final w = state.widget;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = w.activeColor ?? theme.colorScheme.primary;
    final inactive =
        w.inactiveColor ?? (isDark ? Colors.white38 : Colors.black38);

    return Container(
      color: w.backgroundColor,
      child: TabBar(
        controller: state._ctrl,
        isScrollable: w.isScrollable,
        labelColor: active,
        unselectedLabelColor: inactive,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: active,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        tabs: w.tabs.map((t) => _buildTab(t, active, inactive)).toList(),
      ),
    );
  }

  Widget _buildTab(MyTabItem item, Color active, Color inactive) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(item.icon, size: 18),
          const SizedBox(width: 6),
        ],
        Text(item.label),
      ],
    );

    if (item.badgeCount != null || item.showBadgeDot) {
      content = Stack(
        clipBehavior: Clip.none,
        children: [
          content,
          Positioned(
            top: -4,
            right: item.badgeCount != null ? -16 : -10,
            child: _MiniBadge(count: item.badgeCount, dot: item.showBadgeDot),
          ),
        ],
      );
    }

    return Tab(child: content);
  }
}

// ─────────────────────────────────────────
//  PILL STYLE
// ─────────────────────────────────────────

class _PillTabBar extends StatelessWidget {
  final _MyTabBarState state;
  const _PillTabBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final w = state.widget;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = w.activeColor ?? theme.colorScheme.primary;
    final inactive =
        w.inactiveColor ?? (isDark ? Colors.white60 : Colors.black54);

    final tabs = w.tabs.asMap().entries.map((e) {
      final isActive = e.key == state._current;
      return GestureDetector(
        onTap: () => state._select(e.key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: isActive ? active : Colors.transparent,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (e.value.icon != null) ...[
                    Icon(
                      e.value.icon,
                      size: 16,
                      color: isActive ? Colors.white : inactive,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    e.value.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                      color: isActive ? Colors.white : inactive,
                    ),
                  ),
                ],
              ),
              if (e.value.badgeCount != null || e.value.showBadgeDot)
                Positioned(
                  top: -6,
                  right: -8,
                  child: _MiniBadge(
                    count: e.value.badgeCount,
                    dot: e.value.showBadgeDot,
                  ),
                ),
            ],
          ),
        ),
      );
    }).toList();

    Widget content = Row(
      mainAxisSize: w.isScrollable ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: w.isScrollable
          ? tabs
                .map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: t,
                  ),
                )
                .toList()
          : tabs.map((t) => Expanded(child: Center(child: t))).toList(),
    );

    final container = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:
            w.backgroundColor ??
            (isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.04)),
        borderRadius: BorderRadius.circular(99),
      ),
      child: content,
    );

    if (w.isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: container,
      );
    }
    return container;
  }
}

// ─────────────────────────────────────────
//  SEGMENTED STYLE (iOS-like)
// ─────────────────────────────────────────

class _SegmentedTabBar extends StatelessWidget {
  final _MyTabBarState state;
  const _SegmentedTabBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final w = state.widget;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = w.activeColor ?? theme.colorScheme.primary;
    final inactive =
        w.inactiveColor ?? (isDark ? Colors.white60 : Colors.black54);

    return Container(
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.08)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: w.tabs.asMap().entries.map((e) {
          final isActive = e.key == state._current;
          return Expanded(
            child: GestureDetector(
              onTap: () => state._select(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDark ? const Color(0xFF334155) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (e.value.icon != null) ...[
                          Icon(
                            e.value.icon,
                            size: 15,
                            color: isActive ? active : inactive,
                          ),
                          const SizedBox(width: 5),
                        ],
                        Text(
                          e.value.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: isActive ? active : inactive,
                          ),
                        ),
                      ],
                    ),
                    if (e.value.badgeCount != null || e.value.showBadgeDot)
                      Positioned(
                        top: -8,
                        right: -10,
                        child: _MiniBadge(
                          count: e.value.badgeCount,
                          dot: e.value.showBadgeDot,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  BOXED STYLE — كل تاب card منفصل
// ─────────────────────────────────────────

class _BoxedTabBar extends StatelessWidget {
  final _MyTabBarState state;
  const _BoxedTabBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final w = state.widget;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = w.activeColor ?? theme.colorScheme.primary;
    final inactive =
        w.inactiveColor ?? (isDark ? Colors.white60 : Colors.black54);

    final tabs = w.tabs.asMap().entries.map((e) {
      final isActive = e.key == state._current;
      return GestureDetector(
        onTap: () => state._select(e.key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? active.withOpacity(0.12)
                : (isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.04)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? active : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (e.value.icon != null) ...[
                    Icon(
                      e.value.icon,
                      size: 17,
                      color: isActive ? active : inactive,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    e.value.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                      color: isActive ? active : inactive,
                    ),
                  ),
                ],
              ),
              if (e.value.badgeCount != null || e.value.showBadgeDot)
                Positioned(
                  top: -8,
                  right: -10,
                  child: _MiniBadge(
                    count: e.value.badgeCount,
                    dot: e.value.showBadgeDot,
                  ),
                ),
            ],
          ),
        ),
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs
            .map(
              (t) =>
                  Padding(padding: const EdgeInsets.only(right: 8), child: t),
            )
            .toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  MINI BADGE
// ─────────────────────────────────────────

class _MiniBadge extends StatelessWidget {
  final int? count;
  final bool dot;
  const _MiniBadge({this.count, this.dot = false});

  @override
  Widget build(BuildContext context) {
    if (dot) {
      return Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFFEF4444),
          shape: BoxShape.circle,
        ),
      );
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: Color(0xFFEF4444),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count! > 99 ? '99+' : '$count',
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  MY TABS VIEW — TabBar + TabBarView جاهز
// ─────────────────────────────────────────

class MyTabsView extends StatefulWidget {
  final List<MyTabItem> tabs;
  final List<Widget> children;
  final MyTabStyle style;
  final Color? activeColor;
  final EdgeInsetsGeometry? tabBarPadding;
  final bool isScrollable;
  final ValueChanged<int>? onChanged;

  const MyTabsView({
    super.key,
    required this.tabs,
    required this.children,
    this.style = MyTabStyle.underline,
    this.activeColor,
    this.tabBarPadding,
    this.isScrollable = false,
    this.onChanged,
  }) : assert(
         tabs.length == children.length,
         'MyTabsView: عدد tabs يجب أن يساوي عدد children',
       );

  @override
  State<MyTabsView> createState() => _MyTabsViewState();
}

class _MyTabsViewState extends State<MyTabsView> with TickerProviderStateMixin {
  late TabController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              widget.tabBarPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: MyTabBar(
            controller: _ctrl,
            tabs: widget.tabs,
            style: widget.style,
            activeColor: widget.activeColor,
            isScrollable: widget.isScrollable,
            onChanged: widget.onChanged,
          ),
        ),
        Expanded(
          child: TabBarView(controller: _ctrl, children: widget.children),
        ),
      ],
    );
  }
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  MY TABS VIEW — الطريقة الأسرع (TabBar + TabBarView)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyTabsView(
  style: MyTabStyle.segmented,
  tabs: const [
    MyTabItem(label: 'الكل'),
    MyTabItem(label: 'نشطة'),
    MyTabItem(label: 'مكتملة', badgeCount: 3),
  ],
  children: [
    AllOrdersTab(),
    ActiveOrdersTab(),
    CompletedOrdersTab(),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STYLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyTabStyle.underline  // خط تحت التاب ← default, مناسب للأعلى
MyTabStyle.segmented  // iOS style — كبسولة موحدة
MyTabStyle.pill       // التاب النشط بخلفية ملونة كاملة
MyTabStyle.boxed      // كل تاب card مستقل بحدود

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  MY TAB BAR — مستقل (بدون TabBarView)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

int _selectedTab = 0;

MyTabBar(
  style: MyTabStyle.pill,
  initialIndex: _selectedTab,
  onChanged: (i) => setState(() => _selectedTab = i),
  tabs: const [
    MyTabItem(label: 'تفاصيل', icon: Icons.info_outline),
    MyTabItem(label: 'تقييمات', icon: Icons.star_outline, badgeCount: 124),
    MyTabItem(label: 'شحن', icon: Icons.local_shipping_outlined),
  ],
)

// عرض المحتوى يدوياً
IndexedStack(
  index: _selectedTab,
  children: [DetailsTab(), ReviewsTab(), ShippingTab()],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Scrollable مع تابات كثيرة
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyTabsView(
  isScrollable: true,
  style: MyTabStyle.boxed,
  tabs: const [
    MyTabItem(label: 'الكل'),
    MyTabItem(label: 'إلكترونيات'),
    MyTabItem(label: 'ملابس'),
    MyTabItem(label: 'كتب'),
    MyTabItem(label: 'رياضة'),
    MyTabItem(label: 'منزل'),
  ],
  children: [...],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مع Badges
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyTabItem(label: 'الرسائل', badgeCount: 5)
MyTabItem(label: 'التحديثات', showBadgeDot: true)

*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyAppBar — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography (Syne + DM Sans)
//  يستبدل: AppBar + SliverAppBar
//  Import: import 'core/widgets/my_app_bar.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyAppBarStyle {
  solid, // خلفية صلبة عادية ← default
  transparent, // شفاف (فوق صورة أو gradient)
  gradient, // gradient من primary
  frosted, // زجاجي شفاف (blur)
  colored, // لون primary كامل
}

enum MyAppBarSize {
  small, // 48px
  medium, // 56px ← default (standard)
  large, // 64px
}

// ─────────────────────────────────────────
//  MAIN WIDGET — PreferredSizeWidget
// ─────────────────────────────────────────

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  // ── العنوان ──
  final String? title;
  final Widget? titleWidget; // widget مخصص بدل النص
  final bool centerTitle;

  // ── الأزرار ──
  final Widget? leading; // زر يسار (افتراضي: back)
  final bool automaticallyImplyLeading;
  final List<Widget>? actions; // أزرار يمين

  // ── المظهر ──
  final MyAppBarStyle style;
  final MyAppBarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor; // لون العنوان والأيقونات
  final double elevation;
  final bool showDivider; // خط سفلي

  // ── Status Bar ──
  final Brightness? statusBarBrightness;

  // ── Bottom Widget (تبس / سيرش) ──
  final PreferredSizeWidget? bottom;

  // ── تخصيص اختياري ──
  final TextStyle? titleStyle;
  final double? toolbarHeight;

  const MyAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.style = MyAppBarStyle.solid,
    this.size = MyAppBarSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showDivider = false,
    this.statusBarBrightness,
    this.bottom,
    this.titleStyle,
    this.toolbarHeight,
  });

  // ─── Named Constructors ───

  /// AppBar شفاف — فوق صورة أو gradient
  const MyAppBar.transparent({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.foregroundColor = Colors.white,
    this.size = MyAppBarSize.medium,
    this.bottom,
    this.titleStyle,
  }) : style = MyAppBarStyle.transparent,
       backgroundColor = Colors.transparent,
       elevation = 0,
       showDivider = false,
       statusBarBrightness = Brightness.dark,
       toolbarHeight = null;

  /// AppBar بلون primary — لصفحات رئيسية
  const MyAppBar.colored({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.size = MyAppBarSize.medium,
    this.bottom,
    this.titleStyle,
  }) : style = MyAppBarStyle.colored,
       backgroundColor = null,
       foregroundColor = Colors.white,
       elevation = 0,
       showDivider = false,
       statusBarBrightness = Brightness.dark,
       toolbarHeight = null;

  /// AppBar بحث — مع SearchBar مدمج
  const MyAppBar.search({
    super.key,
    this.title,
    this.centerTitle = false,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.size = MyAppBarSize.medium,
    required PreferredSizeWidget searchBar,
  }) : style = MyAppBarStyle.solid,
       titleWidget = null,
       backgroundColor = null,
       foregroundColor = null,
       elevation = 0,
       showDivider = true,
       statusBarBrightness = null,
       bottom = searchBar,
       titleStyle = null,
       toolbarHeight = null;

  /// AppBar بسيط للـ modal / bottom screen
  const MyAppBar.modal({
    super.key,
    required String this.title,
    this.actions,
    VoidCallback? onClose,
  }) : titleWidget = null,
       centerTitle = true,
       leading = null,
       automaticallyImplyLeading = false,
       style = MyAppBarStyle.solid,
       backgroundColor = null,
       foregroundColor = null,
       elevation = 0,
       showDivider = true,
       statusBarBrightness = null,
       bottom = null,
       titleStyle = null,
       toolbarHeight = null,
       size = MyAppBarSize.medium;

  // ─── PreferredSizeWidget ───
  @override
  Size get preferredSize {
    final h = toolbarHeight ?? _heightForSize(size);
    return Size.fromHeight(h + (bottom?.preferredSize.height ?? 0));
  }

  double _heightForSize(MyAppBarSize s) {
    switch (s) {
      case MyAppBarSize.small:
        return 48;
      case MyAppBarSize.medium:
        return 56;
      case MyAppBarSize.large:
        return 64;
    }
  }

  // ─── Style Resolution ───
  Color _resolveBg(BuildContext context, bool isDark) {
    if (backgroundColor != null) return backgroundColor!;
    switch (style) {
      case MyAppBarStyle.transparent:
        return Colors.transparent;
      case MyAppBarStyle.colored:
      case MyAppBarStyle.gradient:
        return Theme.of(context).colorScheme.primary;
      case MyAppBarStyle.frosted:
        return (isDark ? Colors.black : Colors.white).withOpacity(0.7);
      case MyAppBarStyle.solid:
        return isDark ? const Color(0xFF1E293B) : Colors.white;
    }
  }

  Color _resolveFg(BuildContext context, bool isDark) {
    if (foregroundColor != null) return foregroundColor!;
    switch (style) {
      case MyAppBarStyle.colored:
      case MyAppBarStyle.gradient:
      case MyAppBarStyle.transparent:
        return Colors.white;
      case MyAppBarStyle.frosted:
      case MyAppBarStyle.solid:
        return isDark ? Colors.white : const Color(0xFF0F172A);
    }
  }

  SystemUiOverlayStyle _resolveOverlay(bool isDark, Color fg) {
    final isDarkFg =
        ThemeData.estimateBrightnessForColor(fg) == Brightness.dark;
    // ignore: unused_local_variable
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkFg ? Brightness.dark : Brightness.light,
      statusBarBrightness: isDarkFg ? Brightness.light : Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = _resolveBg(context, isDark);
    final fg = _resolveFg(context, isDark);
    final h = toolbarHeight ?? _heightForSize(size);

    // Gradient decoration
    final isGradient = style == MyAppBarStyle.gradient;

    Widget appBar = AppBar(
      toolbarHeight: h,
      backgroundColor: isGradient ? Colors.transparent : bg,
      foregroundColor: fg,
      elevation: elevation,
      shadowColor: Colors.black.withOpacity(0.08),
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: _resolveOverlay(isDark, fg),

      // ── Leading ──
      leading:
          leading ??
          (automaticallyImplyLeading && Navigator.of(context).canPop()
              ? _DefaultBackButton(color: fg)
              : null),

      // ── Title ──
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style:
                      (titleStyle ??
                              theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: size == MyAppBarSize.large ? 20 : 17,
                                letterSpacing: -0.3,
                              ))
                          ?.copyWith(color: fg),
                )
              : null),

      // ── Actions ──
      actions: actions,

      // ── Bottom ──
      bottom: showDivider && bottom == null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.06),
              ),
            )
          : bottom,

      // ── Flexible Space (للـ gradient) ──
      flexibleSpace: isGradient
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            )
          : null,
    );

    return appBar;
  }
}

// ─────────────────────────────────────────
//  DEFAULT BACK BUTTON
// ─────────────────────────────────────────

class _DefaultBackButton extends StatelessWidget {
  final Color color;
  const _DefaultBackButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: color),
      onPressed: () => Navigator.of(context).pop(),
      tooltip: 'رجوع',
    );
  }
}

// ─────────────────────────────────────────
//  ACTION BUTTON HELPERS
// ─────────────────────────────────────────

/// زر أيقونة جاهز للـ actions
class MyAppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final int? badgeCount;
  final bool showBadgeDot;
  final String? tooltip;

  const MyAppBarAction({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.badgeCount,
    this.showBadgeDot = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final fg =
        color ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xFF0F172A));

    Widget btn = IconButton(
      icon: Icon(icon, size: 22, color: fg),
      onPressed: onTap,
      tooltip: tooltip,
      splashRadius: 20,
    );

    if (badgeCount != null || showBadgeDot) {
      btn = Stack(
        clipBehavior: Clip.none,
        children: [
          btn,
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
              padding: badgeCount != null
                  ? const EdgeInsets.symmetric(horizontal: 3)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 1.5,
                ),
              ),
              child: badgeCount != null
                  ? Text(
                      badgeCount! > 99 ? '99+' : '$badgeCount',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(width: 6, height: 6),
            ),
          ),
        ],
      );
    }

    return btn;
  }
}

// ─────────────────────────────────────────
//  SLIVER APP BAR — للصفحات القابلة للطي
// ─────────────────────────────────────────

class MySliverAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? flexibleContent; // الصورة أو الـ hero
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final bool snap;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;

  const MySliverAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.flexibleContent,
    this.expandedHeight = 250,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primary;
    final fg = foregroundColor ?? Colors.white;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: pinned,
      floating: floating,
      snap: snap,
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading:
          leading ??
          (automaticallyImplyLeading && Navigator.of(context).canPop()
              ? _DefaultBackButton(color: fg)
              : null),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 14),
        title:
            titleWidget ??
            (title != null
                ? Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  )
                : null),
        background:
            flexibleContent ??
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bg, bg.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BASIC
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Scaffold(
  appBar: MyAppBar(title: 'الرئيسية'),
  body: ...,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STYLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAppBar(title: 'Solid',       style: MyAppBarStyle.solid)        // ← default
MyAppBar(title: 'Gradient',    style: MyAppBarStyle.gradient)
MyAppBar.transparent(title: 'شفاف')
MyAppBar.colored(title: 'ملون')

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SIZES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAppBar(title: 'Small',  size: MyAppBarSize.small)   // 48px
MyAppBar(title: 'Medium', size: MyAppBarSize.medium)  // 56px ← default
MyAppBar(title: 'Large',  size: MyAppBarSize.large)   // 64px

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAppBar(
  title: 'الرسائل',
  actions: [
    MyAppBarAction(icon: Icons.search_rounded, onTap: _search),
    MyAppBarAction(
      icon: Icons.notifications_outlined,
      badgeCount: 3,
      onTap: _openNotifications,
    ),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  NAMED CONSTRUCTORS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// شفاف فوق صورة
MyAppBar.transparent(
  title: 'الصورة',
  actions: [MyAppBarAction(icon: Icons.share)],
)

// بلون primary
MyAppBar.colored(
  title: 'الملف الشخصي',
  actions: [MyAppBarAction(icon: Icons.edit)],
)

// Modal / Bottomsheet
Scaffold(appBar: MyAppBar.modal(title: 'إضافة منشور'))

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SLIVER APP BAR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CustomScrollView(
  slivers: [
    MySliverAppBar(
      title: 'صفحة المنتج',
      expandedHeight: 300,
      flexibleContent: Image.network(url, fit: BoxFit.cover),
      actions: [
        MyAppBarAction(icon: Icons.favorite_border),
        MyAppBarAction(icon: Icons.share),
      ],
    ),
    SliverList(...),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CUSTOM TITLE WIDGET
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAppBar(
  titleWidget: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      MyAvatar(name: 'أسامة', size: MyAvatarSize.xs),
      SizedBox(width: 8),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أسامة العمري', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          Text('متصل الآن', style: TextStyle(fontSize: 11, color: Colors.green)),
        ],
      ),
    ],
  ),
)

*/

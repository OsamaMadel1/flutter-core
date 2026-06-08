import 'package:flutter/material.dart';

// ============================================================
//  MyCard — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: Card + Container + InkWell بجميع أشكالها
//  Import: import 'core/widgets/my_card.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyCardVariant {
  elevated, // ظل تحت البطاقة ← default
  outlined, // حدود فقط
  filled, // خلفية مملوءة خفيفة
  ghost, // شفاف بدون حدود أو ظل
  colored, // لون primary كخلفية
}

enum MyCardSize {
  sm, // padding 12
  md, // padding 16 ← default
  lg, // padding 20
  xl, // padding 24
}

enum MyCardRadius {
  sm, // 8
  md, // 12 ← default
  lg, // 16
  xl, // 20
  pill, // 999
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyCard extends StatelessWidget {
  // ── المحتوى ──
  final Widget child;

  // ── المظهر ──
  final MyCardVariant variant;
  final MyCardSize size;
  final MyCardRadius radius;

  // ── الأبعاد ──
  final double? width;
  final double? height;

  // ── التفاعل ──
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  // ── تخصيص اختياري ──
  final Color? backgroundColor;
  final Color? borderColor;
  final double? customElevation;
  final double? customBorderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool clipContent; // يقص المحتوى عند الحواف

  // ── Gradient ──
  final Gradient? gradient;

  // ── Glow / Shadow ──
  final Color? shadowColor;
  final bool showGlow; // glow بلون primary

  const MyCard({
    super.key,
    required this.child,
    this.variant = MyCardVariant.elevated,
    this.size = MyCardSize.md,
    this.radius = MyCardRadius.md,
    this.width,
    this.height,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.borderColor,
    this.customElevation,
    this.customBorderRadius,
    this.padding,
    this.margin,
    this.clipContent = true,
    this.gradient,
    this.shadowColor,
    this.showGlow = false,
  });

  // ─── Named Constructors ───

  /// بطاقة قابلة للنقر — مع ripple effect
  const MyCard.clickable({
    Key? key,
    required Widget child,
    required VoidCallback onTap,
    MyCardVariant variant = MyCardVariant.elevated,
    MyCardSize size = MyCardSize.md,
    MyCardRadius radius = MyCardRadius.md,
    double? width,
    double? height,
    VoidCallback? onLongPress,
    Color? backgroundColor,
  }) : this(
         key: key,
         child: child,
         onTap: onTap,
         onLongPress: onLongPress,
         variant: variant,
         size: size,
         radius: radius,
         width: width,
         height: height,
         backgroundColor: backgroundColor,
         clipContent: true,
         gradient: null,
         shadowColor: null,
         showGlow: false,
         borderColor: null,
         customElevation: null,
         customBorderRadius: null,
         padding: null,
         margin: null,
       );

  /// بطاقة بـ gradient
  const MyCard.gradient({
    Key? key,
    required Widget child,
    required Gradient gradient,
    MyCardSize size = MyCardSize.md,
    MyCardRadius radius = MyCardRadius.md,
    double? width,
    double? height,
    VoidCallback? onTap,
    bool showGlow = true,
  }) : this(
         key: key,
         child: child,
         gradient: gradient,
         size: size,
         radius: radius,
         width: width,
         height: height,
         onTap: onTap,
         variant: MyCardVariant.elevated,
         showGlow: showGlow,
         clipContent: true,
         backgroundColor: null,
         borderColor: null,
         shadowColor: null,
         customElevation: null,
         customBorderRadius: null,
         padding: null,
         margin: null,
         onLongPress: null,
       );

  /// بطاقة outlined — حدود فقط
  const MyCard.outlined({
    Key? key,
    required Widget child,
    MyCardSize size = MyCardSize.md,
    MyCardRadius radius = MyCardRadius.md,
    double? width,
    double? height,
    VoidCallback? onTap,
    Color? borderColor,
  }) : this(
         key: key,
         child: child,
         variant: MyCardVariant.outlined,
         size: size,
         radius: radius,
         width: width,
         height: height,
         onTap: onTap,
         borderColor: borderColor,
         clipContent: true,
         gradient: null,
         backgroundColor: null,
         shadowColor: null,
         showGlow: false,
         customElevation: null,
         customBorderRadius: null,
         padding: null,
         margin: null,
         onLongPress: null,
       );

  /// بطاقة بلون primary
  const MyCard.colored({
    Key? key,
    required Widget child,
    MyCardSize size = MyCardSize.md,
    MyCardRadius radius = MyCardRadius.md,
    double? width,
    double? height,
    VoidCallback? onTap,
    bool showGlow = true,
  }) : this(
         key: key,
         child: child,
         variant: MyCardVariant.colored,
         size: size,
         radius: radius,
         width: width,
         height: height,
         onTap: onTap,
         showGlow: showGlow,
         clipContent: true,
         gradient: null,
         backgroundColor: null,
         borderColor: null,
         shadowColor: null,
         customElevation: null,
         customBorderRadius: null,
         padding: null,
         margin: null,
         onLongPress: null,
       );

  // ─── Radius Resolution ───
  double get _resolvedRadius {
    if (customBorderRadius != null) return customBorderRadius!;
    switch (radius) {
      case MyCardRadius.sm:
        return 8;
      case MyCardRadius.md:
        return 12;
      case MyCardRadius.lg:
        return 16;
      case MyCardRadius.xl:
        return 20;
      case MyCardRadius.pill:
        return 999;
    }
  }

  // ─── Padding Resolution ───
  EdgeInsetsGeometry get _resolvedPadding {
    if (padding != null) return padding!;
    switch (size) {
      case MyCardSize.sm:
        return const EdgeInsets.all(12);
      case MyCardSize.md:
        return const EdgeInsets.all(16);
      case MyCardSize.lg:
        return const EdgeInsets.all(20);
      case MyCardSize.xl:
        return const EdgeInsets.all(24);
    }
  }

  // ─── Style Resolution ───
  _CardStyle _resolveStyle(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    Color bg;
    Color? border;
    List<BoxShadow> shadows = [];

    switch (variant) {
      case MyCardVariant.elevated:
        bg =
            backgroundColor ??
            (isDark ? const Color(0xFF1E293B) : Colors.white);
        shadows = [
          BoxShadow(
            color: (shadowColor ?? Colors.black).withOpacity(
              isDark ? 0.3 : 0.07,
            ),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: (shadowColor ?? Colors.black).withOpacity(
              isDark ? 0.1 : 0.03,
            ),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ];
        break;

      case MyCardVariant.outlined:
        bg =
            backgroundColor ??
            (isDark ? const Color(0xFF1E293B) : Colors.white);
        border =
            borderColor ??
            (isDark
                ? Colors.white.withOpacity(0.12)
                : Colors.black.withOpacity(0.1));
        break;

      case MyCardVariant.filled:
        bg =
            backgroundColor ??
            (isDark
                ? Colors.white.withOpacity(0.06)
                : primary.withOpacity(0.05));
        break;

      case MyCardVariant.ghost:
        bg = Colors.transparent;
        break;

      case MyCardVariant.colored:
        bg = backgroundColor ?? primary;
        if (showGlow) {
          shadows = [
            BoxShadow(
              color: primary.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ];
        }
        break;
    }

    // Glow override للـ gradient
    if (showGlow && gradient != null && variant != MyCardVariant.colored) {
      shadows = [
        BoxShadow(
          color: primary.withOpacity(0.25),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];
    }

    return _CardStyle(bg: bg, border: border, shadows: shadows);
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle(context);
    final r = _resolvedRadius;
    final p = _resolvedPadding;

    Widget content = Padding(padding: p, child: child);

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: gradient == null ? style.bg : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(r),
        border: style.border != null
            ? Border.all(color: style.border!, width: 1.5)
            : null,
        boxShadow: style.shadows.isNotEmpty ? style.shadows : null,
      ),
      child: clipContent
          ? ClipRRect(borderRadius: BorderRadius.circular(r), child: content)
          : content,
    );

    if (onTap != null || onLongPress != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(r),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          highlightColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.04),
          child: card,
        ),
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _CardStyle {
  final Color bg;
  final Color? border;
  final List<BoxShadow> shadows;

  const _CardStyle({required this.bg, this.border, this.shadows = const []});
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BASIC
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyCard(child: Text('مرحباً'))

MyCard(
  variant: MyCardVariant.elevated,
  child: Column(children: [
    Text('العنوان', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('المحتوى'),
  ]),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  VARIANTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyCard(variant: MyCardVariant.elevated, child: ...)   // ← default
MyCard(variant: MyCardVariant.outlined, child: ...)
MyCard(variant: MyCardVariant.filled,   child: ...)
MyCard(variant: MyCardVariant.ghost,    child: ...)
MyCard(variant: MyCardVariant.colored,  child: ...)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  NAMED CONSTRUCTORS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// قابلة للنقر
MyCard.clickable(
  onTap: () => _navigate(),
  child: ListTile(title: Text('اضغط هنا')),
)

// Gradient
MyCard.gradient(
  gradient: LinearGradient(
    colors: [AppColors.primary600, AppColors.primary400],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  showGlow: true,
  child: Text('بطاقة ملونة', style: TextStyle(color: Colors.white)),
)

// Outlined
MyCard.outlined(child: Text('بحدود فقط'))

// Colored
MyCard.colored(child: Text('بلون primary', style: TextStyle(color: Colors.white)))

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SIZES & RADIUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyCard(size: MyCardSize.sm,  child: ...)   // padding 12
MyCard(size: MyCardSize.md,  child: ...)   // padding 16 ← default
MyCard(size: MyCardSize.lg,  child: ...)   // padding 20
MyCard(size: MyCardSize.xl,  child: ...)   // padding 24

MyCard(radius: MyCardRadius.sm,   child: ...)  // 8px
MyCard(radius: MyCardRadius.md,   child: ...)  // 12px ← default
MyCard(radius: MyCardRadius.lg,   child: ...)  // 16px
MyCard(radius: MyCardRadius.xl,   child: ...)  // 20px
MyCard(radius: MyCardRadius.pill, child: ...)  // دائري

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  أمثلة تطبيقية
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// بطاقة منتج
MyCard.clickable(
  onTap: () => _openProduct(product),
  radius: MyCardRadius.lg,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: Image.network(product.image, height: 160, fit: BoxFit.cover),
      ),
      Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${product.price} ريال'),
        ]),
      ),
    ],
  ),
  padding: EdgeInsets.zero,
)

// بطاقة إحصاءات
MyCard.gradient(
  gradient: LinearGradient(colors: [AppColors.primary700, AppColors.primary500]),
  child: Column(children: [
    Text('إجمالي المبيعات', style: TextStyle(color: Colors.white70)),
    Text('12,450 ريال', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
  ]),
)

// بطاقة إشعار
MyCard(
  variant: MyCardVariant.outlined,
  onTap: _openNotification,
  child: Row(children: [
    Icon(Icons.notifications_outlined),
    SizedBox(width: 12),
    Expanded(child: Text('لديك رسالة جديدة')),
    Text('الآن', style: TextStyle(fontSize: 11)),
  ]),
)

*/

import 'package:flutter/material.dart';

// ============================================================
//  MyEmptyState — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: كل حالات الفراغ والخطأ وعدم الاتصال في التطبيق
//  Import: import 'core/widgets/my_empty_state.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyEmptyType {
  empty, // لا توجد بيانات ← default
  search, // لا نتائج بحث
  error, // خطأ عام
  network, // لا اتصال
  noFavorites, // لا مفضلة
  noNotifications, // لا إشعارات
  noMessages, // لا رسائل
  noOrders, // لا طلبات
  custom, // مخصص كامل
}

enum MyEmptySize {
  sm, // صغير — في داخل Card
  md, // متوسط ← default
  lg, // كبير — صفحة كاملة
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyEmptyState extends StatelessWidget {
  // ── المحتوى ──
  final MyEmptyType type;
  final String? title;
  final String? subtitle;
  final Widget? illustration; // صورة/أيقونة مخصصة
  final String? emoji; // emoji بدل الأيقونة

  // ── الأزرار ──
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  // ── المظهر ──
  final MyEmptySize size;
  final bool showIcon;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  const MyEmptyState({
    super.key,
    this.type = MyEmptyType.empty,
    this.title,
    this.subtitle,
    this.illustration,
    this.emoji,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.size = MyEmptySize.md,
    this.showIcon = true,
    this.iconColor,
    this.padding,
  });

  // ─── Named Constructors ───

  /// لا توجد بيانات عامة
  const MyEmptyState.empty({
    Key? key,
    String title = 'لا توجد بيانات',
    String subtitle = 'لا يوجد شيء هنا بعد',
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.empty,
         title: title,
         subtitle: subtitle,
         primaryActionLabel: primaryActionLabel,
         onPrimaryAction: onPrimaryAction,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا نتائج بحث
  const MyEmptyState.search({
    Key? key,
    String? query,
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.search,
         title: 'لا توجد نتائج',
         subtitle: 'لم نجد نتائج مطابقة لبحثك',
         primaryActionLabel: primaryActionLabel ?? 'مسح البحث',
         onPrimaryAction: onPrimaryAction,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// خطأ عام مع إعادة محاولة
  const MyEmptyState.error({
    Key? key,
    String title = 'حدث خطأ ما',
    String subtitle = 'حاول مرة أخرى أو تواصل مع الدعم',
    String? retryLabel,
    VoidCallback? onRetry,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.error,
         title: title,
         subtitle: subtitle,
         primaryActionLabel: retryLabel ?? 'إعادة المحاولة',
         onPrimaryAction: onRetry,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا اتصال بالإنترنت
  const MyEmptyState.network({
    Key? key,
    VoidCallback? onRetry,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.network,
         title: 'لا يوجد اتصال',
         subtitle: 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى',
         primaryActionLabel: 'إعادة المحاولة',
         onPrimaryAction: onRetry,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا مفضلة
  const MyEmptyState.noFavorites({
    Key? key,
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.noFavorites,
         title: 'لا توجد مفضلة',
         subtitle: 'أضف عناصر إلى مفضلتك لتظهر هنا',
         primaryActionLabel: primaryActionLabel ?? 'تصفح الآن',
         onPrimaryAction: onPrimaryAction,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا إشعارات
  const MyEmptyState.noNotifications({
    Key? key,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.noNotifications,
         title: 'لا توجد إشعارات',
         subtitle: 'ستظهر هنا إشعاراتك الجديدة',
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         primaryActionLabel: null,
         onPrimaryAction: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا رسائل
  const MyEmptyState.noMessages({
    Key? key,
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.noMessages,
         title: 'لا توجد رسائل',
         subtitle: 'ابدأ محادثة جديدة مع أصدقائك',
         primaryActionLabel: primaryActionLabel ?? 'رسالة جديدة',
         onPrimaryAction: onPrimaryAction,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  /// لا طلبات
  const MyEmptyState.noOrders({
    Key? key,
    String? primaryActionLabel,
    VoidCallback? onPrimaryAction,
    MyEmptySize size = MyEmptySize.md,
  }) : this(
         key: key,
         type: MyEmptyType.noOrders,
         title: 'لا توجد طلبات',
         subtitle: 'لم تقم بأي طلبات بعد',
         primaryActionLabel: primaryActionLabel ?? 'تسوق الآن',
         onPrimaryAction: onPrimaryAction,
         size: size,
         showIcon: true,
         illustration: null,
         emoji: null,
         secondaryActionLabel: null,
         onSecondaryAction: null,
         iconColor: null,
         padding: null,
       );

  // ─── Type Config ───
  _EmptyConfig _resolveConfig(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final error = Theme.of(context).colorScheme.error;

    switch (type) {
      case MyEmptyType.empty:
        return _EmptyConfig(
          icon: Icons.inbox_outlined,
          color: primary.withOpacity(0.6),
          emoji: '📭',
        );
      case MyEmptyType.search:
        return _EmptyConfig(
          icon: Icons.search_off_rounded,
          color: primary.withOpacity(0.6),
          emoji: '🔍',
        );
      case MyEmptyType.error:
        return _EmptyConfig(
          icon: Icons.error_outline_rounded,
          color: error,
          emoji: '⚠️',
        );
      case MyEmptyType.network:
        return _EmptyConfig(
          icon: Icons.wifi_off_rounded,
          color: const Color(0xFF64748B),
          emoji: '📡',
        );
      case MyEmptyType.noFavorites:
        return _EmptyConfig(
          icon: Icons.favorite_border_rounded,
          color: const Color(0xFFEC4899),
          emoji: '💔',
        );
      case MyEmptyType.noNotifications:
        return _EmptyConfig(
          icon: Icons.notifications_none_rounded,
          color: primary.withOpacity(0.6),
          emoji: '🔔',
        );
      case MyEmptyType.noMessages:
        return _EmptyConfig(
          icon: Icons.chat_bubble_outline_rounded,
          color: primary.withOpacity(0.6),
          emoji: '💬',
        );
      case MyEmptyType.noOrders:
        return _EmptyConfig(
          icon: Icons.shopping_bag_outlined,
          color: primary.withOpacity(0.6),
          emoji: '🛍️',
        );
      case MyEmptyType.custom:
        return _EmptyConfig(
          icon: Icons.widgets_outlined,
          color: primary.withOpacity(0.6),
          emoji: '✨',
        );
    }
  }

  // ─── Size Config ───
  _SizeConfig _resolveSizeConfig() {
    switch (size) {
      case MyEmptySize.sm:
        return const _SizeConfig(
          iconSize: 48,
          bgSize: 80,
          titleSize: 14,
          subtitleSize: 12,
          spacing: 8,
        );
      case MyEmptySize.md:
        return const _SizeConfig(
          iconSize: 60,
          bgSize: 100,
          titleSize: 16,
          subtitleSize: 13,
          spacing: 12,
        );
      case MyEmptySize.lg:
        return const _SizeConfig(
          iconSize: 72,
          bgSize: 120,
          titleSize: 18,
          subtitleSize: 14,
          spacing: 16,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = _resolveConfig(context);
    final sc = _resolveSizeConfig();
    final color = iconColor ?? config.color;

    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.all(sc.spacing * 2.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Illustration / Icon ──
            if (illustration != null)
              illustration!
            else if (showIcon) ...[
              Container(
                width: sc.bgSize,
                height: sc.bgSize,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: emoji != null
                      ? Text(
                          emoji!,
                          style: TextStyle(fontSize: sc.iconSize * 0.6),
                        )
                      : Icon(config.icon, size: sc.iconSize, color: color),
                ),
              ),
              SizedBox(height: sc.spacing * 1.5),
            ],

            // ── Title ──
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sc.titleSize,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  height: 1.3,
                ),
              ),
              SizedBox(height: sc.spacing * 0.5),
            ],

            // ── Subtitle ──
            if (subtitle != null) ...[
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sc.subtitleSize,
                  color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
                  height: 1.6,
                ),
              ),
            ],

            // ── Actions ──
            if (primaryActionLabel != null || secondaryActionLabel != null) ...[
              SizedBox(height: sc.spacing * 2),
              if (primaryActionLabel != null)
                _ActionButton(
                  label: primaryActionLabel!,
                  onTap: onPrimaryAction,
                  color: color,
                  isPrimary: true,
                ),
              if (secondaryActionLabel != null) ...[
                SizedBox(height: sc.spacing),
                _ActionButton(
                  label: secondaryActionLabel!,
                  onTap: onSecondaryAction,
                  color: color,
                  isPrimary: false,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  ACTION BUTTON
// ─────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final bool isPrimary;

  const _ActionButton({
    required this.label,
    this.onTap,
    required this.color,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return SizedBox(
        width: 200,
        height: 44,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color.withOpacity(0.7),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _EmptyConfig {
  final IconData icon;
  final Color color;
  final String emoji;
  const _EmptyConfig({
    required this.icon,
    required this.color,
    required this.emoji,
  });
}

class _SizeConfig {
  final double iconSize, bgSize, titleSize, subtitleSize, spacing;
  const _SizeConfig({
    required this.iconSize,
    required this.bgSize,
    required this.titleSize,
    required this.subtitleSize,
    required this.spacing,
  });
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Named Constructors — الأكثر استخداماً
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyEmptyState.empty()
MyEmptyState.search(onPrimaryAction: _clearSearch)
MyEmptyState.error(onRetry: _fetchData)
MyEmptyState.network(onRetry: _retry)
MyEmptyState.noFavorites(onPrimaryAction: _browse)
MyEmptyState.noNotifications()
MyEmptyState.noMessages(onPrimaryAction: _newMessage)
MyEmptyState.noOrders(onPrimaryAction: _shop)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مخصص بالكامل
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyEmptyState(
  type: MyEmptyType.custom,
  emoji: '🎉',
  title: 'أنت في القائمة!',
  subtitle: 'سنخبرك عند إطلاق التطبيق',
  primaryActionLabel: 'دعوة صديق',
  onPrimaryAction: _shareInvite,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مع FutureBuilder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FutureBuilder(
  future: _fetchData(),
  builder: (ctx, snap) {
    if (snap.connectionState == ConnectionState.waiting)
      return MyPageLoading();
    if (snap.hasError)
      return MyEmptyState.error(onRetry: _fetchData);
    if (snap.data?.isEmpty ?? true)
      return MyEmptyState.empty(
        primaryActionLabel: 'إضافة عنصر',
        onPrimaryAction: _addItem,
      );
    return MyList(data: snap.data!);
  },
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  في Sliver (CustomScrollView)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SliverFillRemaining(
  child: MyEmptyState.noFavorites(
    onPrimaryAction: () => context.go('/home'),
  ),
)

*/

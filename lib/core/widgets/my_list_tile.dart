import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyListTile — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: ListTile + CheckboxListTile + SwitchListTile + RadioListTile
//  Import: import 'core/widgets/my_list_tile.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyTileVariant {
  basic, // عادي ← default
  chevron, // سهم يمين للتنقل
  checkbox, // صندوق تحديد
  switcher, // مفتاح تبديل
  radio, // اختيار واحد
  danger, // خطر/حذف — نص وأيقونة أحمر
}

enum MyTileSize {
  sm, // compact
  md, // standard ← default
  lg, // comfortable
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyListTile extends StatelessWidget {
  // ── المحتوى ──
  final String title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;

  // ── الأيقونات ──
  final IconData? leadingIcon;
  final Widget? leadingWidget; // widget مخصص بدل الأيقونة
  final Color? leadingIconColor;
  final bool showLeadingBackground; // دائرة/مربع خلف الأيقونة
  final Color? leadingBgColor;
  final Widget? trailing; // widget يمين مخصص

  // ── النوع ──
  final MyTileVariant variant;
  final MyTileSize size;

  // ── التفاعل ──
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  // ── للـ Checkbox ──
  final bool? checked;
  final ValueChanged<bool?>? onChanged;

  // ── للـ Switch ──
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  // ── للـ Radio ──
  final Object? radioValue;
  final Object? radioGroupValue;
  final ValueChanged<Object?>? onRadioChanged;

  // ── المظهر ──
  final bool showDivider;
  final bool isEnabled;
  final Color? tileColor;
  final double? customBorderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool dense;
  final bool enableHaptic;

  const MyListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.titleWidget,
    this.subtitleWidget,
    this.leadingIcon,
    this.leadingWidget,
    this.leadingIconColor,
    this.showLeadingBackground = false,
    this.leadingBgColor,
    this.trailing,
    this.variant = MyTileVariant.basic,
    this.size = MyTileSize.md,
    this.onTap,
    this.onLongPress,
    this.checked,
    this.onChanged,
    this.switchValue,
    this.onSwitchChanged,
    this.radioValue,
    this.radioGroupValue,
    this.onRadioChanged,
    this.showDivider = false,
    this.isEnabled = true,
    this.tileColor,
    this.customBorderRadius,
    this.contentPadding,
    this.dense = false,
    this.enableHaptic = true,
  });

  // ─── Named Constructors ───

  /// عنصر تنقل — مع سهم يمين
  const MyListTile.navigation({
    Key? key,
    required String title,
    String? subtitle,
    IconData? leadingIcon,
    Widget? leadingWidget,
    Color? leadingIconColor,
    Color? leadingBgColor,
    bool showLeadingBackground = true,
    VoidCallback? onTap,
    MyTileSize size = MyTileSize.md,
    bool showDivider = false,
    Widget? trailing,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leadingIcon: leadingIcon,
         leadingWidget: leadingWidget,
         leadingIconColor: leadingIconColor,
         leadingBgColor: leadingBgColor,
         showLeadingBackground: showLeadingBackground,
         variant: MyTileVariant.chevron,
         onTap: onTap,
         size: size,
         showDivider: showDivider,
         trailing: trailing,
       );

  /// عنصر تأكيد — Checkbox
  const MyListTile.checkbox({
    Key? key,
    required String title,
    String? subtitle,
    required bool checked,
    required ValueChanged<bool?> onChanged,
    IconData? leadingIcon,
    MyTileSize size = MyTileSize.md,
    bool showDivider = false,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leadingIcon: leadingIcon,
         variant: MyTileVariant.checkbox,
         checked: checked,
         onChanged: onChanged,
         size: size,
         showDivider: showDivider,
       );

  /// عنصر تبديل — Switch
  const MyListTile.switcher({
    Key? key,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? leadingIcon,
    Color? leadingIconColor,
    Color? leadingBgColor,
    bool showLeadingBackground = true,
    MyTileSize size = MyTileSize.md,
    bool showDivider = false,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leadingIcon: leadingIcon,
         leadingIconColor: leadingIconColor,
         leadingBgColor: leadingBgColor,
         showLeadingBackground: showLeadingBackground,
         variant: MyTileVariant.switcher,
         switchValue: value,
         onSwitchChanged: onChanged,
         size: size,
         showDivider: showDivider,
       );

  /// عنصر اختيار — Radio
  const MyListTile.radio({
    Key? key,
    required String title,
    String? subtitle,
    required Object value,
    required Object? groupValue,
    required ValueChanged<Object?> onChanged,
    MyTileSize size = MyTileSize.md,
    bool showDivider = false,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         variant: MyTileVariant.radio,
         radioValue: value,
         radioGroupValue: groupValue,
         onRadioChanged: onChanged,
         size: size,
         showDivider: showDivider,
       );

  /// عنصر خطر — حذف / تسجيل خروج
  const MyListTile.danger({
    Key? key,
    required String title,
    String? subtitle,
    IconData? leadingIcon,
    VoidCallback? onTap,
    MyTileSize size = MyTileSize.md,
    bool showDivider = false,
  }) : this(
         key: key,
         title: title,
         subtitle: subtitle,
         leadingIcon: leadingIcon ?? Icons.delete_outline_rounded,
         variant: MyTileVariant.danger,
         onTap: onTap,
         size: size,
         showDivider: showDivider,
       );

  // ─── Size Config ───
  _SizeConfig _resolveSize() {
    switch (size) {
      case MyTileSize.sm:
        return const _SizeConfig(
          verticalPadding: 8,
          iconSize: 18,
          iconBoxSize: 32,
          titleSize: 13,
          subtitleSize: 11,
          iconRadius: 8,
        );
      case MyTileSize.md:
        return const _SizeConfig(
          verticalPadding: 12,
          iconSize: 20,
          iconBoxSize: 38,
          titleSize: 14,
          subtitleSize: 12,
          iconRadius: 10,
        );
      case MyTileSize.lg:
        return const _SizeConfig(
          verticalPadding: 16,
          iconSize: 22,
          iconBoxSize: 44,
          titleSize: 16,
          subtitleSize: 13,
          iconRadius: 12,
        );
    }
  }

  // ─── Leading Widget ───
  Widget? _buildLeading(
    BuildContext context,
    _SizeConfig sc,
    Color primary,
    bool isDark,
  ) {
    final iconColor = leadingIconColor ?? primary;
    final bgColor = leadingBgColor ?? primary.withOpacity(0.12);

    Widget? iconWidget;

    if (leadingWidget != null) {
      iconWidget = leadingWidget!;
    } else if (leadingIcon != null) {
      final icon = Icon(
        leadingIcon,
        size: sc.iconSize,
        color: variant == MyTileVariant.danger
            ? Theme.of(context).colorScheme.error
            : iconColor,
      );

      if (showLeadingBackground) {
        iconWidget = Container(
          width: sc.iconBoxSize,
          height: sc.iconBoxSize,
          decoration: BoxDecoration(
            color: variant == MyTileVariant.danger
                ? Theme.of(context).colorScheme.error.withOpacity(0.12)
                : bgColor,
            borderRadius: BorderRadius.circular(sc.iconRadius),
          ),
          child: Center(child: icon),
        );
      } else {
        iconWidget = icon;
      }
    }

    return iconWidget;
  }

  // ─── Trailing Widget ───
  Widget? _buildTrailing(BuildContext context, Color primary, bool isDark) {
    // custom trailing overrides everything
    if (trailing != null) return trailing;

    switch (variant) {
      case MyTileVariant.chevron:
        return Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: isDark ? Colors.white24 : Colors.black26,
        );

      case MyTileVariant.checkbox:
        return Checkbox(
          value: checked ?? false,
          onChanged: isEnabled ? onChanged : null,
          activeColor: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(
            color: isDark ? Colors.white38 : Colors.black26,
            width: 1.5,
          ),
        );

      case MyTileVariant.switcher:
        return Switch(
          value: switchValue ?? false,
          onChanged: isEnabled ? onSwitchChanged : null,
          activeColor: primary,
        );

      case MyTileVariant.radio:
        return Radio<Object>(
          value: radioValue ?? '',
          groupValue: radioGroupValue,
          onChanged: isEnabled ? onRadioChanged : null,
          activeColor: primary,
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final error = theme.colorScheme.error;
    final sc = _resolveSize();

    final isInteractive =
        onTap != null ||
        variant == MyTileVariant.checkbox ||
        variant == MyTileVariant.switcher ||
        variant == MyTileVariant.radio;

    final titleColor = variant == MyTileVariant.danger
        ? error
        : (isDark ? Colors.white : const Color(0xFF0F172A));

    final subtitleColor = isDark ? Colors.white54 : const Color(0xFF64748B);

    final hPadding =
        contentPadding ??
        EdgeInsets.symmetric(horizontal: 16, vertical: sc.verticalPadding);

    Widget tile = Padding(
      padding: hPadding,
      child: Row(
        children: [
          // ── Leading ──
          if (_buildLeading(context, sc, primary, isDark) != null) ...[
            _buildLeading(context, sc, primary, isDark)!,
            const SizedBox(width: 14),
          ],

          // ── Content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleWidget ??
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: sc.titleSize,
                        fontWeight: FontWeight.w600,
                        color: isEnabled
                            ? titleColor
                            : titleColor.withOpacity(0.4),
                        height: 1.3,
                      ),
                    ),
                if (subtitle != null || subtitleWidget != null) ...[
                  const SizedBox(height: 2),
                  subtitleWidget ??
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: sc.subtitleSize,
                          color: isEnabled
                              ? subtitleColor
                              : subtitleColor.withOpacity(0.4),
                          height: 1.4,
                        ),
                      ),
                ],
              ],
            ),
          ),

          // ── Trailing ──
          if (_buildTrailing(context, primary, isDark) != null) ...[
            const SizedBox(width: 8),
            _buildTrailing(context, primary, isDark)!,
          ],
        ],
      ),
    );

    // ── Tap Handling ──
    if (isInteractive && isEnabled) {
      VoidCallback? tapAction;

      switch (variant) {
        case MyTileVariant.checkbox:
          tapAction = () {
            if (enableHaptic) HapticFeedback.lightImpact();
            onChanged?.call(!(checked ?? false));
          };
          break;
        case MyTileVariant.switcher:
          tapAction = () {
            if (enableHaptic) HapticFeedback.lightImpact();
            onSwitchChanged?.call(!(switchValue ?? false));
          };
          break;
        case MyTileVariant.radio:
          tapAction = () {
            if (enableHaptic) HapticFeedback.lightImpact();
            onRadioChanged?.call(radioValue);
          };
          break;
        default:
          tapAction = onTap != null
              ? () {
                  if (enableHaptic) HapticFeedback.lightImpact();
                  onTap!();
                }
              : null;
      }

      final r = customBorderRadius ?? 0.0;
      tile = InkWell(
        onTap: tapAction,
        onLongPress: onLongPress,
        borderRadius: r > 0 ? BorderRadius.circular(r) : null,
        splashColor: primary.withOpacity(0.08),
        highlightColor: primary.withOpacity(0.04),
        child: tile,
      );
    }

    // ── Background ──
    if (tileColor != null) {
      tile = ColoredBox(color: tileColor!, child: tile);
    }

    // ── Divider ──
    if (showDivider) {
      tile = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tile,
          Divider(
            height: 1,
            indent: leadingIcon != null || leadingWidget != null ? 68 : 16,
            endIndent: 16,
            color: isDark
                ? Colors.white.withOpacity(0.07)
                : Colors.black.withOpacity(0.06),
          ),
        ],
      );
    }

    return tile;
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _SizeConfig {
  final double verticalPadding;
  final double iconSize;
  final double iconBoxSize;
  final double titleSize;
  final double subtitleSize;
  final double iconRadius;

  const _SizeConfig({
    required this.verticalPadding,
    required this.iconSize,
    required this.iconBoxSize,
    required this.titleSize,
    required this.subtitleSize,
    required this.iconRadius,
  });
}

// ─────────────────────────────────────────
//  MY SETTINGS GROUP — مجموعة إعدادات جاهزة
// ─────────────────────────────────────────

class MySettingsGroup extends StatelessWidget {
  final String? header;
  final List<Widget> tiles;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const MySettingsGroup({
    super.key,
    this.header,
    required this.tiles,
    this.borderRadius = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 4, bottom: 8, left: 4),
              child: Text(
                header!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(tiles.length, (i) {
                  final isLast = i == tiles.length - 1;
                  if (isLast) return tiles[i];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      tiles[i],
                      Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 0,
                        color: isDark
                            ? Colors.white.withOpacity(0.06)
                            : Colors.black.withOpacity(0.05),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
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

MyListTile(title: 'الإعدادات')

MyListTile(
  title: 'الملف الشخصي',
  subtitle: 'تعديل بياناتك الشخصية',
  leadingIcon: Icons.person_outline,
  showLeadingBackground: true,
  onTap: _openProfile,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  NAMED CONSTRUCTORS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// تنقل (مع سهم)
MyListTile.navigation(
  title: 'الإشعارات',
  subtitle: '5 إشعارات جديدة',
  leadingIcon: Icons.notifications_outlined,
  onTap: _openNotifications,
)

// Checkbox
MyListTile.checkbox(
  title: 'أوافق على الشروط',
  checked: _accepted,
  onChanged: (v) => setState(() => _accepted = v ?? false),
)

// Switch
MyListTile.switcher(
  title: 'الوضع الليلي',
  subtitle: 'تفعيل المظهر الداكن',
  leadingIcon: Icons.dark_mode_outlined,
  value: _darkMode,
  onChanged: (v) => setState(() => _darkMode = v),
)

// Radio
MyListTile.radio(
  title: 'العربية',
  value: 'ar',
  groupValue: _language,
  onChanged: (v) => setState(() => _language = v as String),
)

// Danger
MyListTile.danger(
  title: 'حذف الحساب',
  subtitle: 'لا يمكن التراجع عن هذا الإجراء',
  onTap: _confirmDelete,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SETTINGS GROUP — مجموعة إعدادات
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MySettingsGroup(
  header: 'الحساب',
  tiles: [
    MyListTile.navigation(
      title: 'الملف الشخصي',
      leadingIcon: Icons.person_outline,
      leadingBgColor: AppColors.primary600,
      onTap: _openProfile,
    ),
    MyListTile.navigation(
      title: 'الأمان',
      leadingIcon: Icons.security_outlined,
      leadingBgColor: Colors.green,
      onTap: _openSecurity,
    ),
    MyListTile.switcher(
      title: 'الإشعارات',
      leadingIcon: Icons.notifications_outlined,
      value: _notifications,
      onChanged: (v) => setState(() => _notifications = v),
    ),
  ],
)

*/

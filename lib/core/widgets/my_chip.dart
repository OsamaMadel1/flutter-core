import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyChip + MyBadge — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: Chip + FilterChip + ChoiceChip + ActionChip + Badge
//  Import: import 'core/widgets/my_chip.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyChipVariant {
  filled, // خلفية مملوءة ← default
  outlined, // حدود فقط
  soft, // خلفية خفيفة (tinted)
  ghost, // شفاف
}

enum MyChipSize {
  sm, // صغير
  md, // متوسط ← default
  lg, // كبير
}

enum MyBadgeVariant {
  filled, // ← default
  outlined,
  soft,
  dot, // نقطة صغيرة فقط
}

// ─────────────────────────────────────────
//  MY CHIP
// ─────────────────────────────────────────

class MyChip extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete; // × للحذف
  final bool isSelected;
  final bool isDisabled;
  final MyChipVariant variant;
  final MyChipSize size;
  final Color? color; // يتجاوز اللون الافتراضي
  final bool enableHaptic;

  const MyChip({
    super.key,
    required this.label,
    this.leadingIcon,
    this.leadingWidget,
    this.trailingIcon,
    this.onTap,
    this.onDelete,
    this.isSelected = false,
    this.isDisabled = false,
    this.variant = MyChipVariant.soft,
    this.size = MyChipSize.md,
    this.color,
    this.enableHaptic = true,
  });

  // ─── Named Constructors ───

  /// Chip فلتر — للتصفية (قابل للتحديد)
  const MyChip.filter({
    Key? key,
    required String label,
    bool isSelected = false,
    VoidCallback? onTap,
    IconData? leadingIcon,
    Color? color,
    MyChipSize size = MyChipSize.md,
  }) : this(
         key: key,
         label: label,
         isSelected: isSelected,
         onTap: onTap,
         leadingIcon: leadingIcon,
         color: color,
         size: size,
         variant: MyChipVariant.soft,
         enableHaptic: true,
       );

  /// Chip إجراء — مع أيقونة
  const MyChip.action({
    Key? key,
    required String label,
    required VoidCallback onTap,
    required IconData icon,
    Color? color,
    MyChipSize size = MyChipSize.md,
    MyChipVariant variant = MyChipVariant.outlined,
  }) : this(
         key: key,
         label: label,
         onTap: onTap,
         leadingIcon: icon,
         color: color,
         size: size,
         variant: variant,
         enableHaptic: true,
       );

  /// Chip قابل للحذف
  const MyChip.deletable({
    Key? key,
    required String label,
    required VoidCallback onDelete,
    IconData? leadingIcon,
    Color? color,
    MyChipSize size = MyChipSize.md,
  }) : this(
         key: key,
         label: label,
         onDelete: onDelete,
         leadingIcon: leadingIcon,
         color: color,
         size: size,
         variant: MyChipVariant.soft,
         enableHaptic: true,
       );

  // ─── Size Config ───
  _ChipSize _sc() {
    switch (size) {
      case MyChipSize.sm:
        return const _ChipSize(h: 24, px: 8, font: 11, icon: 13, gap: 4);
      case MyChipSize.md:
        return const _ChipSize(h: 32, px: 12, font: 13, icon: 15, gap: 6);
      case MyChipSize.lg:
        return const _ChipSize(h: 40, px: 16, font: 15, icon: 17, gap: 8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = color ?? theme.colorScheme.primary;
    final sc = _sc();

    // ── Colors ──
    Color bg, fg, border;
    switch (variant) {
      case MyChipVariant.filled:
        bg = isSelected
            ? primary
            : (isDark ? Colors.white12 : Colors.black.withOpacity(0.07));
        fg = isSelected
            ? Colors.white
            : (isDark ? Colors.white70 : Colors.black54);
        border = Colors.transparent;
        break;
      case MyChipVariant.outlined:
        bg = isSelected ? primary.withOpacity(0.1) : Colors.transparent;
        fg = isSelected ? primary : (isDark ? Colors.white70 : Colors.black54);
        border = isSelected
            ? primary
            : (isDark ? Colors.white24 : Colors.black.withOpacity(0.2));
        break;
      case MyChipVariant.soft:
        bg = isSelected
            ? primary.withOpacity(0.18)
            : (isDark
                  ? Colors.white.withOpacity(0.07)
                  : primary.withOpacity(0.08));
        fg = isSelected ? primary : (isDark ? Colors.white60 : Colors.black54);
        border = Colors.transparent;
        break;
      case MyChipVariant.ghost:
        bg = Colors.transparent;
        fg = isSelected ? primary : (isDark ? Colors.white60 : Colors.black45);
        border = Colors.transparent;
        break;
    }

    if (isDisabled) {
      bg = isDark
          ? Colors.white.withOpacity(0.06)
          : Colors.black.withOpacity(0.05);
      fg = isDark ? Colors.white24 : Colors.black26;
      border = Colors.transparent;
    }

    Widget chip = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: sc.h,
      padding: EdgeInsets.symmetric(horizontal: sc.px),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(sc.h / 2),
        border: border != Colors.transparent
            ? Border.all(color: border, width: 1.5)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingWidget != null) ...[
            leadingWidget!,
            SizedBox(width: sc.gap),
          ],
          if (leadingIcon != null && leadingWidget == null) ...[
            Icon(leadingIcon, size: sc.icon, color: fg),
            SizedBox(width: sc.gap),
          ],
          if (isSelected &&
              variant == MyChipVariant.soft &&
              leadingIcon == null) ...[
            Icon(Icons.check_rounded, size: sc.icon, color: fg),
            SizedBox(width: sc.gap),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: sc.font,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: fg,
            ),
          ),
          if (trailingIcon != null) ...[
            SizedBox(width: sc.gap),
            Icon(trailingIcon, size: sc.icon, color: fg),
          ],
          if (onDelete != null) ...[
            SizedBox(width: sc.gap * 0.5),
            GestureDetector(
              onTap: () {
                if (enableHaptic) HapticFeedback.lightImpact();
                onDelete?.call();
              },
              child: Icon(
                Icons.close_rounded,
                size: sc.icon,
                color: fg.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );

    if ((onTap != null) && !isDisabled) {
      chip = GestureDetector(
        onTap: () {
          if (enableHaptic) HapticFeedback.lightImpact();
          onTap!();
        },
        child: chip,
      );
    }

    return chip;
  }
}

// ─────────────────────────────────────────
//  MY BADGE — علامة إشعار / حالة / تصنيف
// ─────────────────────────────────────────

class MyBadge extends StatelessWidget {
  final String? label; // نص أو رقم — null للـ dot
  final Color? color;
  final Color? textColor;
  final MyBadgeVariant variant;
  final double? size; // حجم مخصص
  final bool pulse; // تأثير نبض للتنبيه

  const MyBadge({
    super.key,
    this.label,
    this.color,
    this.textColor,
    this.variant = MyBadgeVariant.filled,
    this.size,
    this.pulse = false,
  });

  // ─── Named Constructors ───

  /// badge رقمي (إشعارات)
  const MyBadge.count(int count, {Key? key, Color? color, bool pulse = false})
    : this(
        key: key,
        label: count > 99 ? '99+' : '$count',
        color: color,
        variant: MyBadgeVariant.filled,
        pulse: pulse,
      );

  /// badge نقطة
  const MyBadge.dot({Key? key, Color? color, bool pulse = false})
    : this(
        label: null,
        color: color,
        variant: MyBadgeVariant.dot,
        pulse: pulse,
      );

  /// badge نص (حالة)
  const MyBadge.status(String status, {Key? key, required Color color})
    : this(label: status, color: color, variant: MyBadgeVariant.soft);

  /// badge عدد طلبات / مبلغ
  const MyBadge.outlined(String label, {Key? key, Color? color})
    : this(label: label, color: color, variant: MyBadgeVariant.outlined);

  @override
  Widget build(BuildContext context) {
    final primary = color ?? Theme.of(context).colorScheme.error;
    final isDot = variant == MyBadgeVariant.dot || label == null;
    final dotSize = size ?? (isDot ? 10.0 : null);

    Color bg, fg, border;
    switch (variant) {
      case MyBadgeVariant.filled:
        bg = primary;
        fg = textColor ?? Colors.white;
        border = Colors.transparent;
        break;
      case MyBadgeVariant.outlined:
        bg = Colors.transparent;
        fg = textColor ?? primary;
        border = primary;
        break;
      case MyBadgeVariant.soft:
        bg = primary.withOpacity(0.15);
        fg = textColor ?? primary;
        border = Colors.transparent;
        break;
      case MyBadgeVariant.dot:
        bg = primary;
        fg = Colors.white;
        border = Colors.transparent;
        break;
    }

    Widget badge = Container(
      width: isDot ? dotSize : null,
      height: isDot ? dotSize : 18,
      constraints: isDot ? null : const BoxConstraints(minWidth: 18),
      padding: isDot ? null : const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: bg,
        shape: isDot ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isDot ? null : BorderRadius.circular(99),
        border: border != Colors.transparent
            ? Border.all(color: border, width: 1.5)
            : null,
      ),
      child: isDot
          ? null
          : Center(
              child: Text(
                label!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: fg,
                  height: 1,
                ),
              ),
            ),
    );

    if (pulse) {
      badge = _PulseBadge(child: badge, color: primary);
    }

    return badge;
  }
}

// ─────────────────────────────────────────
//  PULSE ANIMATION
// ─────────────────────────────────────────

class _PulseBadge extends StatefulWidget {
  final Widget child;
  final Color color;
  const _PulseBadge({required this.child, required this.color});

  @override
  State<_PulseBadge> createState() => _PulseBadgeState();
}

class _PulseBadgeState extends State<_PulseBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(_anim.value * 0.3),
              shape: BoxShape.circle,
            ),
          ),
          child!,
        ],
      ),
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────
//  CHIP GROUP — مجموعة chips للتصفية
// ─────────────────────────────────────────

class MyChipGroup extends StatelessWidget {
  final List<String> items;
  final List<String> selected;
  final ValueChanged<String> onToggle;
  final bool multiSelect;
  final Color? activeColor;
  final MyChipSize size;
  final MyChipVariant variant;
  final bool wrap;

  const MyChipGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onToggle,
    this.multiSelect = true,
    this.activeColor,
    this.size = MyChipSize.md,
    this.variant = MyChipVariant.soft,
    this.wrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final chips = items
        .map(
          (item) => MyChip(
            label: item,
            isSelected: selected.contains(item),
            onTap: () => onToggle(item),
            size: size,
            variant: variant,
            color: activeColor,
          ),
        )
        .toList();

    if (wrap) {
      return Wrap(spacing: 8, runSpacing: 8, children: chips);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips
            .map(
              (c) => Padding(padding: const EdgeInsets.only(left: 8), child: c),
            )
            .toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _ChipSize {
  final double h, px, font, icon, gap;
  const _ChipSize({
    required this.h,
    required this.px,
    required this.font,
    required this.icon,
    required this.gap,
  });
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CHIP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyChip(label: 'Flutter')
MyChip(label: 'مميز', isSelected: true)
MyChip.filter(label: 'الكل', isSelected: _all, onTap: _toggleAll)
MyChip.action(label: 'مشاركة', icon: Icons.share, onTap: _share)
MyChip.deletable(label: 'أسامة', onDelete: () => _remove('أسامة'))

// Variants
MyChip(label: 'filled',   variant: MyChipVariant.filled,   ...)
MyChip(label: 'outlined', variant: MyChipVariant.outlined, ...)
MyChip(label: 'soft',     variant: MyChipVariant.soft,     ...)  // ← default

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CHIP GROUP — فلاتر
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyChipGroup(
  items: ['الكل', 'طعام', 'مشروبات', 'حلويات'],
  selected: _selectedFilters,
  onToggle: (item) {
    setState(() {
      if (_selectedFilters.contains(item))
        _selectedFilters.remove(item);
      else
        _selectedFilters.add(item);
    });
  },
)

// اختيار واحد فقط
MyChipGroup(
  items: categories,
  selected: [_activeCategory],
  multiSelect: false,
  onToggle: (item) => setState(() => _activeCategory = item),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BADGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyBadge.count(5)                                    // رقم إشعارات
MyBadge.dot(color: Colors.green)                    // نقطة حالة
MyBadge.dot(pulse: true)                            // نبض للتنبيه
MyBadge.status('جديد', color: Colors.green)         // حالة نصية
MyBadge.outlined('PRO', color: AppColors.primary)   // outlined

// مع Stack على أيقونة
Stack(children: [
  Icon(Icons.notifications),
  Positioned(top: 0, right: 0, child: MyBadge.count(3)),
])

*/

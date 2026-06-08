import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyButton — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  Import: import 'core/widgets/my_button.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

/// نوع الزر — يحدد الشكل البصري الكامل
enum MyButtonVariant {
  primary, // لون primary من الثيم
  secondary, // لون secondary
  outline, // حدود فقط، خلفية شفافة
  ghost, // بدون حدود وبدون خلفية
  danger, // errorColor
  success, // successColor
  warning, // warningColor
  neutral, // رمادي محايد
}

/// حجم الزر
enum MyButtonSize {
  xs, // 28px height
  sm, // 36px height
  md, // 44px height  ← default
  lg, // 52px height
  xl, // 60px height
}

/// شكل حواف الزر
enum MyButtonShape {
  rounded, // BorderRadius 12  ← default
  pill, // BorderRadius 999
  square, // BorderRadius 4
  sharp, // BorderRadius 0
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyButton extends StatefulWidget {
  // ── المحتوى ──
  final String? label;
  final Widget? child; // بديل label لمحتوى مخصص
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixWidget; // widget مخصص بدل icon
  final Widget? suffixWidget;

  // ── الوظيفة ──
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isLoading;
  final bool isDisabled;

  // ── المظهر ──
  final MyButtonVariant variant;
  final MyButtonSize size;
  final MyButtonShape shape;
  final bool isExpanded; // عرض كامل (width: double.infinity)

  // ── تخصيص اختياري (يتجاوز الثيم) ──
  final Color? customColor; // يستبدل لون الـ variant
  final Color? customTextColor;
  final double? customBorderRadius;
  final double? customElevation;
  final EdgeInsetsGeometry? customPadding;
  final TextStyle? customTextStyle;
  final double? customIconSize;
  final double? width;
  final double? height;

  // ── تأثيرات ──
  final bool enableHaptic; // اهتزاز خفيف عند الضغط
  final bool enableSplash; // تأثير موجة الضغط
  final Duration animationDuration;

  const MyButton({
    super.key,
    this.label,
    this.child,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isDisabled = false,
    this.variant = MyButtonVariant.primary,
    this.size = MyButtonSize.md,
    this.shape = MyButtonShape.rounded,
    this.isExpanded = false,
    this.customColor,
    this.customTextColor,
    this.customBorderRadius,
    this.customElevation,
    this.customPadding,
    this.customTextStyle,
    this.customIconSize,
    this.width,
    this.height,
    this.enableHaptic = true,
    this.enableSplash = true,
    this.animationDuration = const Duration(milliseconds: 150),
  }) : assert(label != null || child != null, 'يجب تحديد label أو child');

  // ─── Named Constructors (shortcuts) ───

  /// زر أيقونة فقط (مربع أو دائري)
  const MyButton.icon({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    MyButtonVariant variant = MyButtonVariant.primary,
    MyButtonSize size = MyButtonSize.md,
    MyButtonShape shape = MyButtonShape.pill,
    bool isLoading = false,
    bool isDisabled = false,
    Color? customColor,
    Color? customTextColor,
    bool enableHaptic = true,
  }) : this(
         key: key,
         label: ' ',
         prefixIcon: icon,
         onPressed: onPressed,
         variant: variant,
         size: size,
         shape: shape,
         isLoading: isLoading,
         isDisabled: isDisabled,
         customColor: customColor,
         customTextColor: customTextColor,
         enableHaptic: enableHaptic,
         customPadding: EdgeInsets.zero,
       );

  /// زر نص فقط (ghost style)
  const MyButton.text({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    MyButtonSize size = MyButtonSize.md,
    Color? customTextColor,
  }) : this(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: MyButtonVariant.ghost,
         size: size,
         customTextColor: customTextColor,
       );

  /// زر destructive / حذف
  const MyButton.danger({
    Key? key,
    required String label,
    IconData? prefixIcon,
    VoidCallback? onPressed,
    MyButtonSize size = MyButtonSize.md,
    bool isLoading = false,
  }) : this(
         key: key,
         label: label,
         prefixIcon: prefixIcon,
         onPressed: onPressed,
         variant: MyButtonVariant.danger,
         size: size,
         isLoading: isLoading,
       );

  /// زر outline
  const MyButton.outlined({
    Key? key,
    required String label,
    IconData? prefixIcon,
    VoidCallback? onPressed,
    MyButtonSize size = MyButtonSize.md,
    Color? customColor,
  }) : this(
         key: key,
         label: label,
         prefixIcon: prefixIcon,
         onPressed: onPressed,
         variant: MyButtonVariant.outline,
         size: size,
         customColor: customColor,
       );

  @override
  State<MyButton> createState() => _MyButtonState();
}

// ─────────────────────────────────────────
//  STATE
// ─────────────────────────────────────────

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isInteractable =>
      !widget.isDisabled && !widget.isLoading && widget.onPressed != null;

  void _handleTapDown(TapDownDetails _) {
    if (!_isInteractable) return;
    setState(() => _isPressed = true);
    _controller.forward();
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails _) {
    if (!_isInteractable) return;
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  // ─── Style Calculations ───

  _ButtonStyle _resolveStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    Color bg, fg, border;
    double elevation = widget.customElevation ?? 0;

    switch (widget.variant) {
      case MyButtonVariant.primary:
        bg = widget.customColor ?? colorScheme.primary;
        fg = widget.customTextColor ?? colorScheme.onPrimary;
        border = Colors.transparent;
        elevation = widget.customElevation ?? 2;
        break;

      case MyButtonVariant.secondary:
        bg = widget.customColor ?? colorScheme.secondary;
        fg = widget.customTextColor ?? colorScheme.onSecondary;
        border = Colors.transparent;
        elevation = widget.customElevation ?? 1;
        break;

      case MyButtonVariant.outline:
        bg = Colors.transparent;
        fg = widget.customColor ?? colorScheme.primary;
        border = widget.customColor ?? colorScheme.primary;
        break;

      case MyButtonVariant.ghost:
        bg = _isPressed
            ? (widget.customColor ?? colorScheme.primary).withOpacity(0.08)
            : Colors.transparent;
        fg =
            widget.customTextColor ?? widget.customColor ?? colorScheme.primary;
        border = Colors.transparent;
        break;

      case MyButtonVariant.danger:
        bg = widget.customColor ?? colorScheme.error;
        fg = widget.customTextColor ?? colorScheme.onError;
        border = Colors.transparent;
        elevation = widget.customElevation ?? 1;
        break;

      case MyButtonVariant.success:
        bg =
            widget.customColor ??
            (isDark ? const Color(0xFF4CAF50) : const Color(0xFF388E3C));
        fg = widget.customTextColor ?? Colors.white;
        border = Colors.transparent;
        break;

      case MyButtonVariant.warning:
        bg =
            widget.customColor ??
            (isDark ? const Color(0xFFFFB300) : const Color(0xFFF57C00));
        fg = widget.customTextColor ?? Colors.white;
        border = Colors.transparent;
        break;

      case MyButtonVariant.neutral:
        bg =
            widget.customColor ??
            (isDark ? const Color(0xFF424242) : const Color(0xFFEEEEEE));
        fg =
            widget.customTextColor ??
            (isDark ? Colors.white : const Color(0xFF212121));
        border = Colors.transparent;
        break;
    }

    if (widget.isDisabled) {
      bg = bg == Colors.transparent
          ? Colors.transparent
          : (isDark
                ? Colors.white.withOpacity(0.12)
                : Colors.black.withOpacity(0.12));
      fg = isDark
          ? Colors.white.withOpacity(0.38)
          : Colors.black.withOpacity(0.38);
      border = border == Colors.transparent
          ? Colors.transparent
          : (isDark
                ? Colors.white.withOpacity(0.20)
                : Colors.black.withOpacity(0.20));
      elevation = 0;
    }

    return _ButtonStyle(
      backgroundColor: bg,
      foregroundColor: fg,
      borderColor: border,
      elevation: elevation,
    );
  }

  _SizeConfig _resolveSize() {
    switch (widget.size) {
      case MyButtonSize.xs:
        return _SizeConfig(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          iconSize: 14,
          fontSize: 11,
          gap: 4,
          loaderSize: 12,
        );
      case MyButtonSize.sm:
        return _SizeConfig(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          iconSize: 16,
          fontSize: 13,
          gap: 6,
          loaderSize: 14,
        );
      case MyButtonSize.md:
        return _SizeConfig(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          iconSize: 18,
          fontSize: 14,
          gap: 8,
          loaderSize: 16,
        );
      case MyButtonSize.lg:
        return _SizeConfig(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          iconSize: 20,
          fontSize: 16,
          gap: 10,
          loaderSize: 18,
        );
      case MyButtonSize.xl:
        return _SizeConfig(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          iconSize: 22,
          fontSize: 18,
          gap: 12,
          loaderSize: 20,
        );
    }
  }

  double _resolveBorderRadius() {
    if (widget.customBorderRadius != null) return widget.customBorderRadius!;
    switch (widget.shape) {
      case MyButtonShape.rounded:
        return 12;
      case MyButtonShape.pill:
        return 999;
      case MyButtonShape.square:
        return 4;
      case MyButtonShape.sharp:
        return 0;
    }
  }

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle(context);
    final sizeConfig = _resolveSize();
    final borderRadius = _resolveBorderRadius();

    Widget buttonContent = _buildContent(context, style, sizeConfig);

    Widget button = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) =>
          Transform.scale(scale: _scaleAnimation.value, child: child),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: _isInteractable ? widget.onPressed : null,
        onLongPress: _isInteractable ? widget.onLongPress : null,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          width: widget.isExpanded ? double.infinity : widget.width,
          height: widget.height ?? sizeConfig.height,
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: style.borderColor != Colors.transparent
                ? Border.all(color: style.borderColor, width: 1.5)
                : null,
            boxShadow: style.elevation > 0
                ? [
                    BoxShadow(
                      color: style.backgroundColor.withOpacity(0.30),
                      blurRadius: style.elevation * 4,
                      offset: Offset(0, style.elevation),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: widget.enableSplash
                ? InkWell(
                    onTap: _isInteractable ? widget.onPressed : null,
                    borderRadius: BorderRadius.circular(borderRadius),
                    splashColor: style.foregroundColor.withOpacity(0.15),
                    highlightColor: style.foregroundColor.withOpacity(0.08),
                    child: buttonContent,
                  )
                : buttonContent,
          ),
        ),
      ),
    );

    if (widget.isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildContent(
    BuildContext context,
    _ButtonStyle style,
    _SizeConfig sizeConfig,
  ) {
    final padding = widget.customPadding ?? sizeConfig.padding;
    final iconSize = widget.customIconSize ?? sizeConfig.iconSize;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Prefix ──
          if (widget.isLoading)
            _buildLoader(style, sizeConfig)
          else ...[
            if (widget.prefixWidget != null) ...[
              widget.prefixWidget!,
              SizedBox(width: sizeConfig.gap),
            ] else if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                size: iconSize,
                color: style.foregroundColor,
              ),
              SizedBox(width: sizeConfig.gap),
            ],
          ],

          // ── Label / Child ──
          if (!widget.isLoading)
            widget.child ??
                Text(
                  widget.label!,
                  style:
                      (widget.customTextStyle ??
                              TextStyle(
                                fontSize: sizeConfig.fontSize,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ))
                          .copyWith(color: style.foregroundColor),
                ),

          // ── Suffix ──
          if (!widget.isLoading) ...[
            if (widget.suffixWidget != null) ...[
              SizedBox(width: sizeConfig.gap),
              widget.suffixWidget!,
            ] else if (widget.suffixIcon != null) ...[
              SizedBox(width: sizeConfig.gap),
              Icon(
                widget.suffixIcon,
                size: iconSize,
                color: style.foregroundColor,
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildLoader(_ButtonStyle style, _SizeConfig sizeConfig) {
    return SizedBox(
      width: sizeConfig.loaderSize,
      height: sizeConfig.loaderSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(style.foregroundColor),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _ButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double elevation;

  const _ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.elevation,
  });
}

class _SizeConfig {
  final double height;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final double fontSize;
  final double gap;
  final double loaderSize;

  const _SizeConfig({
    required this.height,
    required this.padding,
    required this.iconSize,
    required this.fontSize,
    required this.gap,
    required this.loaderSize,
  });
}

// ============================================================
//  USAGE REFERENCE — أمثلة الاستخدام
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  VARIANTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton(label: 'Primary', onPressed: () {})

MyButton(
  label: 'Secondary',
  variant: MyButtonVariant.secondary,
  onPressed: () {},
)

MyButton(
  label: 'Outlined',
  variant: MyButtonVariant.outline,
  onPressed: () {},
)

MyButton(
  label: 'Ghost',
  variant: MyButtonVariant.ghost,
  onPressed: () {},
)

MyButton(
  label: 'Danger',
  variant: MyButtonVariant.danger,
  onPressed: () {},
)

MyButton(
  label: 'Success',
  variant: MyButtonVariant.success,
  onPressed: () {},
)

MyButton(
  label: 'Warning',
  variant: MyButtonVariant.warning,
  onPressed: () {},
)

MyButton(
  label: 'Neutral',
  variant: MyButtonVariant.neutral,
  onPressed: () {},
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SIZES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton(label: 'XSmall', size: MyButtonSize.xs, onPressed: () {})
MyButton(label: 'Small',  size: MyButtonSize.sm, onPressed: () {})
MyButton(label: 'Medium', size: MyButtonSize.md, onPressed: () {})  // default
MyButton(label: 'Large',  size: MyButtonSize.lg, onPressed: () {})
MyButton(label: 'XLarge', size: MyButtonSize.xl, onPressed: () {})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SHAPES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton(label: 'Rounded', shape: MyButtonShape.rounded, onPressed: () {})
MyButton(label: 'Pill',    shape: MyButtonShape.pill,    onPressed: () {})
MyButton(label: 'Square',  shape: MyButtonShape.square,  onPressed: () {})
MyButton(label: 'Sharp',   shape: MyButtonShape.sharp,   onPressed: () {})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ICONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// أيقونة قبل النص
MyButton(
  label: 'Upload',
  prefixIcon: Icons.upload_rounded,
  onPressed: () {},
)

// أيقونة بعد النص
MyButton(
  label: 'Next',
  suffixIcon: Icons.arrow_forward_rounded,
  onPressed: () {},
)

// أيقونة فقط (Named Constructor)
MyButton.icon(
  icon: Icons.add,
  onPressed: () {},
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STATES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Loading
MyButton(
  label: 'Saving...',
  isLoading: true,
  onPressed: () {},
)

// Disabled
MyButton(
  label: 'Disabled',
  isDisabled: true,
  onPressed: () {},
)

// Expanded (full width)
MyButton(
  label: 'Full Width',
  isExpanded: true,
  onPressed: () {},
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  NAMED CONSTRUCTORS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton.text(label: 'Skip', onPressed: () {})

MyButton.danger(label: 'Delete', prefixIcon: Icons.delete, onPressed: () {})

MyButton.outlined(label: 'Cancel', onPressed: () {})

MyButton.icon(icon: Icons.favorite, variant: MyButtonVariant.danger, onPressed: () {})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CUSTOM OVERRIDE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton(
  label: 'Custom Brand',
  customColor: Color(0xFF6C63FF),
  customTextColor: Colors.white,
  customBorderRadius: 20,
  customElevation: 4,
  customPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  onPressed: () {},
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  COMBINED EXAMPLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyButton(
  label: 'إرسال',
  prefixIcon: Icons.send_rounded,
  variant: MyButtonVariant.primary,
  size: MyButtonSize.lg,
  shape: MyButtonShape.pill,
  isExpanded: true,
  isLoading: _isSubmitting,
  onPressed: _handleSubmit,
)

*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyTextField — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: TextField + TextFormField بجميع أشكالها
//  Import: import 'core/widgets/my_text_field.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyFieldType {
  text,
  email,
  phone,
  password,
  search,
  multiline,
  number,
  url,
}

enum MyFieldVariant {
  outlined, // ← default
  filled,
  underline,
}

enum MyFieldSize {
  sm, // 44px
  md, // 52px ← default
  lg, // 60px
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? counterText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixTap;
  final MyFieldType type;
  final MyFieldVariant variant;
  final MyFieldSize size;
  final bool isRequired;
  final bool isReadOnly;
  final bool isEnabled;
  final bool autofocus;
  final bool showCounter;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final Color? customBorderColor;
  final Color? customFillColor;
  final double? customBorderRadius;
  final TextStyle? customTextStyle;
  final EdgeInsetsGeometry? customContentPadding;

  const MyTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.onSuffixTap,
    this.type = MyFieldType.text,
    this.variant = MyFieldVariant.outlined,
    this.size = MyFieldSize.md,
    this.isRequired = false,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.autofocus = false,
    this.showCounter = false,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputAction,
    this.inputFormatters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.customBorderColor,
    this.customFillColor,
    this.customBorderRadius,
    this.customTextStyle,
    this.customContentPadding,
  });

  // ─── Named Constructors ───

  const MyTextField.email({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label = 'البريد الإلكتروني',
    String? hint = 'example@email.com',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool isRequired = true,
    TextInputAction? textInputAction = TextInputAction.next,
    MyFieldVariant variant = MyFieldVariant.outlined,
    MyFieldSize size = MyFieldSize.md,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         label: label,
         hint: hint,
         type: MyFieldType.email,
         prefixIcon: Icons.email_outlined,
         isRequired: isRequired,
         onChanged: onChanged,
         onSubmitted: onSubmitted,
         validator: validator,
         textInputAction: textInputAction,
         variant: variant,
         size: size,
       );

  const MyTextField.password({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,

    String? label = 'كلمة المرور',
    String? hint = '••••••••',
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool isRequired = true,
    TextInputAction? textInputAction = TextInputAction.done,
    MyFieldVariant variant = MyFieldVariant.outlined,
    MyFieldSize size = MyFieldSize.md,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         label: label,
         hint: hint,
         type: MyFieldType.password,
         prefixIcon: Icons.lock_outline_rounded,
         isRequired: isRequired,
         onChanged: onChanged,
         validator: validator,
         textInputAction: textInputAction,
         variant: variant,
         size: size,
       );

  const MyTextField.search({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hint = 'ابحث هنا...',
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    MyFieldVariant variant = MyFieldVariant.filled,
    MyFieldSize size = MyFieldSize.md,
    double? customBorderRadius = 999,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         hint: hint,
         type: MyFieldType.search,
         prefixIcon: Icons.search_rounded,
         onChanged: onChanged,
         onSubmitted: onSubmitted,
         onTap: onTap,
         variant: variant,
         size: size,
         customBorderRadius: customBorderRadius,
       );

  const MyTextField.phone({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label = 'رقم الهاتف',
    String? hint = '05xxxxxxxx',
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool isRequired = true,
    MyFieldVariant variant = MyFieldVariant.outlined,
    MyFieldSize size = MyFieldSize.md,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         label: label,
         hint: hint,
         type: MyFieldType.phone,
         prefixIcon: Icons.phone_outlined,
         isRequired: isRequired,
         onChanged: onChanged,
         validator: validator,
         textInputAction: TextInputAction.next,
         variant: variant,
         size: size,
       );

  const MyTextField.multiline({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    int maxLines = 5,
    int minLines = 3,
    int? maxLength,
    bool showCounter = true,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    MyFieldVariant variant = MyFieldVariant.outlined,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         label: label,
         hint: hint,
         type: MyFieldType.multiline,
         maxLines: maxLines,
         minLines: minLines,
         maxLength: maxLength,
         showCounter: showCounter,
         onChanged: onChanged,
         validator: validator,
         textInputAction: TextInputAction.newline,
         variant: variant,
       );

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

// ─────────────────────────────────────────
//  STATE
// ─────────────────────────────────────────

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller?.addListener(_onTextChange);
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  void _onTextChange() {
    final hasText = (widget.controller?.text.isNotEmpty) ?? false;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    widget.controller?.removeListener(_onTextChange);
    super.dispose();
  }

  TextInputType get _keyboardType {
    switch (widget.type) {
      case MyFieldType.email:
        return TextInputType.emailAddress;
      case MyFieldType.phone:
        return TextInputType.phone;
      case MyFieldType.password:
        return TextInputType.visiblePassword;
      case MyFieldType.number:
        return TextInputType.number;
      case MyFieldType.url:
        return TextInputType.url;
      case MyFieldType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  bool get _obscure => widget.type == MyFieldType.password && _obscureText;
  int get _maxLines =>
      widget.type == MyFieldType.multiline ? widget.maxLines : 1;

  String? _defaultValidator(String? value) {
    if (widget.isRequired && (value == null || value.trim().isEmpty)) {
      return 'هذا الحقل مطلوب';
    }
    if (value == null || value.isEmpty) return null;
    switch (widget.type) {
      case MyFieldType.email:
        if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(value))
          return 'بريد إلكتروني غير صحيح';
        break;
      case MyFieldType.phone:
        if (!RegExp(r'^[0-9+\-\s]{7,15}$').hasMatch(value))
          return 'رقم هاتف غير صحيح';
        break;
      case MyFieldType.password:
        if (value.length < 8) return 'كلمة المرور 8 أحرف على الأقل';
        break;
      case MyFieldType.url:
        if (!RegExp(r'^https?://').hasMatch(value))
          return 'يجب أن يبدأ بـ http:// أو https://';
        break;
      default:
        break;
    }
    return null;
  }

  Widget? _buildSuffixIcon(Color activeColor) {
    if (widget.type == MyFieldType.password) {
      return GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: _isFocused ? activeColor : activeColor.withOpacity(0.5),
          size: 20,
        ),
      );
    }
    if (widget.type == MyFieldType.search && _hasText) {
      return GestureDetector(
        onTap: () {
          widget.controller?.clear();
          widget.onChanged?.call('');
        },
        child: Icon(
          Icons.cancel_rounded,
          color: activeColor.withOpacity(0.5),
          size: 18,
        ),
      );
    }
    if (widget.suffixWidget != null) return widget.suffixWidget;
    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: Icon(
          widget.suffixIcon,
          color: _isFocused ? activeColor : activeColor.withOpacity(0.5),
          size: 20,
        ),
      );
    }
    return null;
  }

  _SizeConfig _resolveSize() {
    switch (widget.size) {
      case MyFieldSize.sm:
        return _SizeConfig(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          fontSize: 13,
          labelFontSize: 12,
          iconSize: 18,
        );
      case MyFieldSize.md:
        return _SizeConfig(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          fontSize: 14,
          labelFontSize: 13,
          iconSize: 20,
        );
      case MyFieldSize.lg:
        return _SizeConfig(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          fontSize: 16,
          labelFontSize: 14,
          iconSize: 22,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final sizeConfig = _resolveSize();
    final activeColor = colorScheme.primary;
    final errorColor = colorScheme.error;
    final borderRadius = widget.customBorderRadius ?? 12.0;

    Color fillColor;
    if (widget.customFillColor != null) {
      fillColor = widget.customFillColor!;
    } else if (widget.variant == MyFieldVariant.filled) {
      fillColor = isDark
          ? colorScheme.surface.withOpacity(0.6)
          : colorScheme.primary.withOpacity(0.05);
    } else {
      fillColor = isDark ? colorScheme.surface : Colors.white;
    }

    final borderColor =
        widget.customBorderColor ?? (isDark ? Colors.white24 : Colors.black12);

    OutlineInputBorder _border(Color c, {double w = 1.0}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: widget.variant == MyFieldVariant.underline
          ? BorderSide.none
          : BorderSide(color: c, width: w),
    );

    UnderlineInputBorder _uline(Color c, {double w = 1.0}) =>
        UnderlineInputBorder(
          borderSide: BorderSide(color: c, width: w),
        );

    InputBorder _b(Color c, {double w = 1.0}) =>
        widget.variant == MyFieldVariant.underline
        ? _uline(c, w: w)
        : _border(c, w: w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: sizeConfig.labelFontSize,
                color: _isFocused
                    ? activeColor
                    : (isDark ? Colors.white70 : Colors.black54),
                fontWeight: FontWeight.w500,
              ),
              children: widget.isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: errorColor),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          initialValue: widget.controller == null ? widget.initialValue : null,
          obscureText: _obscure,
          keyboardType: _keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: _maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          readOnly: widget.isReadOnly,
          enabled: widget.isEnabled,
          autofocus: widget.autofocus,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: widget.autovalidateMode,
          style:
              (widget.customTextStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        fontSize: sizeConfig.fontSize,
                      ))
                  ?.copyWith(
                    color: widget.isEnabled
                        ? (isDark ? Colors.white : Colors.black87)
                        : (isDark ? Colors.white38 : Colors.black38),
                  ),
          validator: widget.validator ?? _defaultValidator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            helperText: widget.helperText,
            counterText: widget.showCounter ? null : '',
            filled: true,
            fillColor: widget.isEnabled
                ? fillColor
                : fillColor.withOpacity(0.5),
            contentPadding:
                widget.customContentPadding ?? sizeConfig.contentPadding,
            prefixIcon:
                widget.prefixWidget ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        size: sizeConfig.iconSize,
                        color: _isFocused
                            ? activeColor
                            : (isDark ? Colors.white38 : Colors.black38),
                      )
                    : null),
            suffixIcon: _buildSuffixIcon(activeColor),
            enabledBorder: _b(borderColor),
            focusedBorder: _b(activeColor, w: 2),
            errorBorder: _b(errorColor),
            focusedErrorBorder: _b(errorColor, w: 2),
            disabledBorder: _b(borderColor.withOpacity(0.5)),
            hintStyle: TextStyle(
              fontSize: sizeConfig.fontSize,
              color: isDark ? Colors.white30 : Colors.black26,
            ),
            helperStyle: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
            errorStyle: TextStyle(fontSize: 11, color: errorColor),
            counterStyle: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
//  OTP / PIN WIDGET
// ─────────────────────────────────────────

class MyOtpField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Color? customActiveColor;
  final double size;

  const MyOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscureText = false,
    this.customActiveColor,
    this.size = 52,
  });

  @override
  State<MyOtpField> createState() => _MyOtpFieldState();
}

class _MyOtpFieldState extends State<MyOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      final chars = value.split('');
      for (int i = 0; i < widget.length && i < chars.length; i++) {
        _controllers[i].text = chars[i];
      }
      _focusNodes[widget.length - 1].requestFocus();
    } else if (value.isNotEmpty) {
      if (index < widget.length - 1) _focusNodes[index + 1].requestFocus();
    } else {
      if (index > 0) _focusNodes[index - 1].requestFocus();
    }
    final otp = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) widget.onCompleted?.call(otp);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.customActiveColor ?? theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: widget.size,
          height: widget.size,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            obscureText: widget.obscureText,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: widget.length,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: isDark
                  ? theme.colorScheme.surface
                  : activeColor.withOpacity(0.04),
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: activeColor, width: 2),
              ),
            ),
            onChanged: (v) => _onChanged(index, v),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _SizeConfig {
  final EdgeInsetsGeometry contentPadding;
  final double fontSize;
  final double labelFontSize;
  final double iconSize;
  const _SizeConfig({
    required this.contentPadding,
    required this.fontSize,
    required this.labelFontSize,
    required this.iconSize,
  });
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

MyTextField(label: 'الاسم', hint: 'أدخل اسمك', prefixIcon: Icons.person_outline, controller: _ctrl)
MyTextField.email(controller: _emailCtrl)
MyTextField.password(controller: _passCtrl)
MyTextField.phone(controller: _phoneCtrl)
MyTextField.search(controller: _searchCtrl, onChanged: _onSearch)
MyTextField.multiline(label: 'ملاحظات', maxLength: 500, controller: _notesCtrl)

MyOtpField(length: 6, onCompleted: (otp) => _verify(otp))
MyOtpField(length: 4, obscureText: true, onCompleted: (pin) => _verifyPin(pin))

// داخل Form
Form(
  key: _formKey,
  child: Column(children: [
    MyTextField.email(controller: _emailCtrl),
    SizedBox(height: 16),
    MyTextField.password(controller: _passCtrl),
    SizedBox(height: 24),
    MyButton(label: 'دخول', isExpanded: true, onPressed: () {
      if (_formKey.currentState!.validate()) { }
    }),
  ]),
)

*/

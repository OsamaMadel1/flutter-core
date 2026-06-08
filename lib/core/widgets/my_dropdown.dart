import 'package:flutter/material.dart';

// ============================================================
//  MyDropdown — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: DropdownButtonFormField + DropdownButton + PopupMenuButton
//  Import: import 'core/widgets/my_dropdown.dart';
// ============================================================

// ─────────────────────────────────────────
//  MODEL
// ─────────────────────────────────────────

class MyDropdownItem<T> {
  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final bool isDisabled;
  final bool isDivider; // فاصل بين المجموعات

  const MyDropdownItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.leading,
    this.isDisabled = false,
    this.isDivider = false,
  });

  /// فاصل تزييني
  static MyDropdownItem<T> divider<T>() =>
      MyDropdownItem<T>(value: null as T, label: '', isDivider: true);
}

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyDropdownVariant {
  outlined, // حدود ← default
  filled, // خلفية مملوءة
  underline, // خط سفلي فقط
}

enum MyDropdownSize {
  sm,
  md, // ← default
  lg,
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyDropdown<T> extends StatefulWidget {
  final List<MyDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;

  final MyDropdownVariant variant;
  final MyDropdownSize size;
  final bool isRequired;
  final bool isEnabled;
  final bool isSearchable; // بحث داخل القائمة
  final double? customBorderRadius;
  final Color? customBorderColor;
  final int maxMenuHeight;

  const MyDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.hint = 'اختر...',
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.variant = MyDropdownVariant.outlined,
    this.size = MyDropdownSize.md,
    this.isRequired = false,
    this.isEnabled = true,
    this.isSearchable = false,
    this.customBorderRadius,
    this.customBorderColor,
    this.maxMenuHeight = 280,
  });

  // ─── Named Constructors ───

  const MyDropdown.search({
    Key? key,
    required List<MyDropdownItem<T>> items,
    T? value,
    ValueChanged<T?>? onChanged,
    String? label,
    String? hint = 'ابحث أو اختر...',
    IconData? prefixIcon,
    MyDropdownVariant variant = MyDropdownVariant.outlined,
    MyDropdownSize size = MyDropdownSize.md,
    bool isRequired = false,
  }) : this(
         items: items,
         value: value,
         onChanged: onChanged,
         label: label,
         hint: hint,
         prefixIcon: prefixIcon,
         variant: variant,
         size: size,
         isRequired: isRequired,
         isSearchable: true,
       );

  @override
  State<MyDropdown<T>> createState() => _MyDropdownState<T>();
}

class _MyDropdownState<T> extends State<MyDropdown<T>> {
  bool _isFocused = false;

  _SizeConfig get _sc {
    switch (widget.size) {
      case MyDropdownSize.sm:
        return const _SizeConfig(
          height: 44,
          px: 14,
          font: 13,
          lbl: 11,
          icon: 18,
        );
      case MyDropdownSize.md:
        return const _SizeConfig(
          height: 52,
          px: 16,
          font: 14,
          lbl: 12,
          icon: 20,
        );
      case MyDropdownSize.lg:
        return const _SizeConfig(
          height: 60,
          px: 20,
          font: 16,
          lbl: 13,
          icon: 22,
        );
    }
  }

  double get _radius => widget.customBorderRadius ?? 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final error = theme.colorScheme.error;
    final sc = _sc;

    final borderColor =
        widget.customBorderColor ?? (isDark ? Colors.white24 : Colors.black12);

    final fillColor = widget.variant == MyDropdownVariant.filled
        ? (isDark ? Colors.white.withOpacity(0.06) : primary.withOpacity(0.05))
        : (isDark ? const Color(0xFF1E293B) : Colors.white);

    // المحتوى المحدد
    final selectedItem = widget.items
        .where((e) => !e.isDivider && e.value == widget.value)
        .firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label ──
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyle(
                fontSize: sc.lbl,
                fontWeight: FontWeight.w500,
                color: _isFocused
                    ? primary
                    : (isDark ? Colors.white70 : Colors.black54),
              ),
              children: widget.isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: error),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 6),
        ],

        // ── Field ──
        Focus(
          onFocusChange: (v) => setState(() => _isFocused = v),
          child: GestureDetector(
            onTap: widget.isEnabled
                ? () => _showMenu(context, primary, isDark)
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: sc.height,
              padding: EdgeInsets.symmetric(horizontal: sc.px),
              decoration: BoxDecoration(
                color: widget.isEnabled
                    ? fillColor
                    : fillColor.withOpacity(0.5),
                borderRadius: widget.variant != MyDropdownVariant.underline
                    ? BorderRadius.circular(_radius)
                    : null,
                border: widget.variant == MyDropdownVariant.filled
                    ? null
                    : Border.all(
                        color: widget.errorText != null
                            ? error
                            : _isFocused
                            ? primary
                            : borderColor,
                        width: _isFocused ? 2 : 1.5,
                      ),
              ),
              child: Row(
                children: [
                  // Prefix icon
                  if (widget.prefixIcon != null) ...[
                    Icon(
                      widget.prefixIcon,
                      size: sc.icon,
                      color: _isFocused
                          ? primary
                          : (isDark ? Colors.white38 : Colors.black38),
                    ),
                    SizedBox(width: sc.px * 0.6),
                  ],

                  // Selected / hint
                  Expanded(
                    child: selectedItem != null
                        ? Row(
                            children: [
                              if (selectedItem.icon != null) ...[
                                Icon(
                                  selectedItem.icon,
                                  size: sc.icon,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (selectedItem.leading != null) ...[
                                selectedItem.leading!,
                                const SizedBox(width: 8),
                              ],
                              Expanded(
                                child: Text(
                                  selectedItem.label,
                                  style: TextStyle(
                                    fontSize: sc.font,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            widget.hint ?? 'اختر...',
                            style: TextStyle(
                              fontSize: sc.font,
                              color: isDark ? Colors.white30 : Colors.black26,
                            ),
                          ),
                  ),

                  // Chevron
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: sc.icon,
                    color: _isFocused
                        ? primary
                        : (isDark ? Colors.white38 : Colors.black38),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Error / Helper ──
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.error_outline_rounded, size: 12, color: error),
              const SizedBox(width: 4),
              Text(
                widget.errorText!,
                style: TextStyle(fontSize: 11, color: error),
              ),
            ],
          ),
        ] else if (widget.helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ],
      ],
    );
  }

  void _showMenu(BuildContext context, Color primary, bool isDark) {
    setState(() => _isFocused = true);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _DropdownSheet<T>(
        items: widget.items,
        selectedValue: widget.value,
        isSearchable: widget.isSearchable,
        maxHeight: widget.maxMenuHeight.toDouble(),
        onSelect: (v) {
          widget.onChanged?.call(v);
          Navigator.pop(context);
        },
      ),
    ).whenComplete(() => setState(() => _isFocused = false));
  }
}

// ─────────────────────────────────────────
//  DROPDOWN SHEET
// ─────────────────────────────────────────

class _DropdownSheet<T> extends StatefulWidget {
  final List<MyDropdownItem<T>> items;
  final T? selectedValue;
  final bool isSearchable;
  final double maxHeight;
  final ValueChanged<T?> onSelect;

  const _DropdownSheet({
    required this.items,
    required this.selectedValue,
    required this.isSearchable,
    required this.maxHeight,
    required this.onSelect,
  });

  @override
  State<_DropdownSheet<T>> createState() => _DropdownSheetState<T>();
}

class _DropdownSheetState<T> extends State<_DropdownSheet<T>> {
  late List<MyDropdownItem<T>> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
  }

  void _search(String q) {
    setState(() {
      _filtered = q.isEmpty
          ? widget.items
          : widget.items
                .where(
                  (e) =>
                      !e.isDivider &&
                      e.label.toLowerCase().contains(q.toLowerCase()),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final bg = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Search
          if (widget.isSearchable) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                onChanged: _search,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'ابحث...',
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  filled: true,
                  fillColor: isDark
                      ? Colors.white.withOpacity(0.07)
                      : Colors.black.withOpacity(0.04),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ] else
            const SizedBox(height: 8),

          // Items
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final item = _filtered[i];

                if (item.isDivider) {
                  return Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withOpacity(0.06),
                  );
                }

                final isSelected = item.value == widget.selectedValue;
                final isDisabled = item.isDisabled;

                return InkWell(
                  onTap: isDisabled ? null : () => widget.onSelect(item.value),
                  child: Opacity(
                    opacity: isDisabled ? 0.4 : 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      color: isSelected
                          ? primary.withOpacity(0.08)
                          : Colors.transparent,
                      child: Row(
                        children: [
                          if (item.leading != null) ...[
                            item.leading!,
                            const SizedBox(width: 12),
                          ] else if (item.icon != null) ...[
                            Icon(
                              item.icon,
                              size: 20,
                              color: isSelected
                                  ? primary
                                  : (isDark ? Colors.white60 : Colors.black54),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? primary
                                        : (isDark
                                              ? Colors.white
                                              : Colors.black87),
                                  ),
                                ),
                                if (item.subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.black38,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_rounded, color: primary, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _SizeConfig {
  final double height, px, font, lbl, icon;
  const _SizeConfig({
    required this.height,
    required this.px,
    required this.font,
    required this.lbl,
    required this.icon,
  });
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BASIC
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown<String>(
  label: 'الدولة',
  hint: 'اختر الدولة',
  value: _country,
  onChanged: (v) => setState(() => _country = v),
  items: const [
    MyDropdownItem(value: 'sa', label: 'السعودية'),
    MyDropdownItem(value: 'ae', label: 'الإمارات'),
    MyDropdownItem(value: 'kw', label: 'الكويت'),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مع أيقونات وsubtitle
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown<String>(
  label: 'طريقة الدفع',
  prefixIcon: Icons.payment_outlined,
  value: _payment,
  onChanged: (v) => setState(() => _payment = v),
  items: const [
    MyDropdownItem(value: 'mada',   label: 'مدى',    subtitle: 'بطاقة محلية', icon: Icons.credit_card),
    MyDropdownItem(value: 'visa',   label: 'Visa',   subtitle: 'بطاقة دولية', icon: Icons.credit_card),
    MyDropdownItem(value: 'apple',  label: 'Apple Pay', icon: Icons.phone_iphone),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Searchable
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown<String>.search(
  label: 'المدينة',
  hint: 'ابحث عن مدينتك...',
  value: _city,
  onChanged: (v) => setState(() => _city = v),
  items: cities.map((c) => MyDropdownItem(value: c.id, label: c.name)).toList(),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  مع Divider بين المجموعات
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown<String>(
  label: 'الفئة',
  items: [
    MyDropdownItem(value: 'all',  label: 'الكل'),
    MyDropdownItem.divider(),
    MyDropdownItem(value: 'food',  label: 'طعام'),
    MyDropdownItem(value: 'drink', label: 'مشروبات'),
  ],
  value: _category,
  onChanged: (v) => setState(() => _category = v),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Variants & Sizes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown(variant: MyDropdownVariant.outlined,  ...)  // ← default
MyDropdown(variant: MyDropdownVariant.filled,    ...)
MyDropdown(variant: MyDropdownVariant.underline, ...)

MyDropdown(size: MyDropdownSize.sm, ...)
MyDropdown(size: MyDropdownSize.md, ...)  // ← default
MyDropdown(size: MyDropdownSize.lg, ...)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  داخل Form
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyDropdown<String>(
  label: 'الجنسية',
  isRequired: true,
  errorText: _countryError,
  value: _country,
  onChanged: (v) => setState(() {
    _country = v;
    _countryError = null;
  }),
  items: [...],
)

*/

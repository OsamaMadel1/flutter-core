import 'package:flutter/material.dart';

// ============================================================
//  MyDialog — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: AlertDialog + SimpleDialog + BottomSheet + Dialog
//  Import: import 'core/widgets/my_dialog.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyDialogType {
  info,       // معلومات — primary color
  success,    // نجاح — أخضر
  warning,    // تحذير — برتقالي
  danger,     // خطر/حذف — أحمر
  confirm,    // تأكيد عام — neutral
  custom,     // محتوى مخصص كامل
}

enum MySheetSize {
  small,    // ~30% ارتفاع الشاشة
  medium,   // ~50%
  large,    // ~75%
  full,     // 100% مع مقبض
}

// ─────────────────────────────────────────
//  SHOW HELPERS — الدوال الرئيسية
// ─────────────────────────────────────────

/// عرض Dialog — الطريقة الرئيسية
Future<T?> showMyDialog<T>({
  required BuildContext context,
  required MyDialogType type,
  required String title,
  String? message,
  Widget? content,               // محتوى مخصص يحل محل message
  String? confirmLabel,
  String? cancelLabel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  bool showIcon = true,
  Widget? customIcon,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black54,
    builder: (_) => MyDialog(
      type: type,
      title: title,
      message: message,
      content: content,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: onConfirm,
      onCancel: onCancel,
      showIcon: showIcon,
      customIcon: customIcon,
    ),
  );
}

/// عرض Bottom Sheet — الطريقة الرئيسية
Future<T?> showMySheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  MySheetSize size = MySheetSize.medium,
  bool isDismissible = true,
  bool showDragHandle = true,
  bool isScrollable = false,
  Color? backgroundColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => MyBottomSheet(
      title: title,
      size: size,
      showDragHandle: showDragHandle,
      isScrollable: isScrollable,
      backgroundColor: backgroundColor,
      child: child,
    ),
  );
}

// ─────────────────────────────────────────
//  MY DIALOG WIDGET
// ─────────────────────────────────────────

class MyDialog extends StatelessWidget {
  final MyDialogType type;
  final String title;
  final String? message;
  final Widget? content;
  final String? confirmLabel;
  final String? cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showIcon;
  final Widget? customIcon;

  const MyDialog({
    super.key,
    required this.type,
    required this.title,
    this.message,
    this.content,
    this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    this.showIcon = true,
    this.customIcon,
  });

  // ─── Type Config ───
  _TypeConfig _resolveConfig(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (type) {
      case MyDialogType.info:
        return _TypeConfig(
          color: scheme.primary,
          icon: Icons.info_outline_rounded,
          confirmLabel: confirmLabel ?? 'حسناً',
          showCancel: cancelLabel != null,
        );
      case MyDialogType.success:
        return _TypeConfig(
          color: const Color(0xFF22C55E),
          icon: Icons.check_circle_outline_rounded,
          confirmLabel: confirmLabel ?? 'ممتاز',
          showCancel: false,
        );
      case MyDialogType.warning:
        return _TypeConfig(
          color: const Color(0xFFF59E0B),
          icon: Icons.warning_amber_rounded,
          confirmLabel: confirmLabel ?? 'متابعة',
          showCancel: true,
          cancelLabel: cancelLabel ?? 'إلغاء',
        );
      case MyDialogType.danger:
        return _TypeConfig(
          color: scheme.error,
          icon: Icons.delete_outline_rounded,
          confirmLabel: confirmLabel ?? 'حذف',
          showCancel: true,
          cancelLabel: cancelLabel ?? 'إلغاء',
        );
      case MyDialogType.confirm:
        return _TypeConfig(
          color: scheme.primary,
          icon: Icons.help_outline_rounded,
          confirmLabel: confirmLabel ?? 'تأكيد',
          showCancel: true,
          cancelLabel: cancelLabel ?? 'إلغاء',
        );
      case MyDialogType.custom:
        return _TypeConfig(
          color: scheme.primary,
          icon: Icons.widgets_outlined,
          confirmLabel: confirmLabel ?? 'حسناً',
          showCancel: cancelLabel != null,
          cancelLabel: cancelLabel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = _resolveConfig(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.12),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon Header ──
            if (showIcon) ...[
              const SizedBox(height: 28),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: config.color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: customIcon ??
                    Icon(config.icon, color: config.color, size: 32),
              ),
              const SizedBox(height: 16),
            ] else
              const SizedBox(height: 24),

            // ── Title ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ),

            // ── Message / Content ──
            if (message != null || content != null) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: content ??
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white60 : const Color(0xFF64748B),
                        height: 1.6,
                        fontSize: 14,
                      ),
                    ),
              ),
            ],

            const SizedBox(height: 24),

            // ── Divider ──
            Divider(
              height: 1,
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
            ),

            // ── Actions ──
            _buildActions(context, config, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(
      BuildContext context, _TypeConfig config, bool isDark) {
    final hasCancel = config.showCancel || cancelLabel != null;

    if (!hasCancel) {
      // زر واحد — عرض كامل
      return InkWell(
        onTap: () {
          Navigator.of(context).pop(true);
          onConfirm?.call();
        },
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            config.confirmLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: config.color,
            ),
          ),
        ),
      );
    }

    // زرين — cancel | confirm
    return IntrinsicHeight(
      child: Row(
        children: [
          // Cancel
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
                onCancel?.call();
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  config.cancelLabel ?? 'إلغاء',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
                  ),
                ),
              ),
            ),
          ),

          // Divider عمودي
          VerticalDivider(
            width: 1,
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
          ),

          // Confirm
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
                onConfirm?.call();
              },
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  config.confirmLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: type == MyDialogType.danger
                        ? Theme.of(context).colorScheme.error
                        : config.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  MY BOTTOM SHEET WIDGET
// ─────────────────────────────────────────

class MyBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;
  final MySheetSize size;
  final bool showDragHandle;
  final bool isScrollable;
  final Color? backgroundColor;

  const MyBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.size = MySheetSize.medium,
    this.showDragHandle = true,
    this.isScrollable = false,
    this.backgroundColor,
  });

  double _sizeMultiplier() {
    switch (size) {
      case MySheetSize.small:  return 0.32;
      case MySheetSize.medium: return 0.52;
      case MySheetSize.large:  return 0.78;
      case MySheetSize.full:   return 0.95;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenH = MediaQuery.of(context).size.height;
    final bg = backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);

    final sheetContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Drag Handle ──
        if (showDragHandle)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

        // ── Title ──
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark ? Colors.white54 : Colors.black38,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
          ),
        ] else
          const SizedBox(height: 8),

        // ── Content ──
        if (isScrollable)
          Expanded(child: SingleChildScrollView(child: child))
        else
          child,

        // ── Bottom safe area ──
        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ],
    );

    return Container(
      height: screenH * _sizeMultiplier(),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 40,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: isScrollable
          ? sheetContent
          : SingleChildScrollView(child: sheetContent),
    );
  }
}

// ─────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────

class _TypeConfig {
  final Color color;
  final IconData icon;
  final String confirmLabel;
  final bool showCancel;
  final String? cancelLabel;

  const _TypeConfig({
    required this.color,
    required this.icon,
    required this.confirmLabel,
    this.showCancel = false,
    this.cancelLabel,
  });
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  DIALOGS — showMyDialog()
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Info
showMyDialog(
  context: context,
  type: MyDialogType.info,
  title: 'تنبيه',
  message: 'تم تحديث البيانات بنجاح.',
);

// Success
showMyDialog(
  context: context,
  type: MyDialogType.success,
  title: 'تم الحفظ!',
  message: 'تم حفظ التغييرات بنجاح.',
);

// Warning
showMyDialog(
  context: context,
  type: MyDialogType.warning,
  title: 'تحذير',
  message: 'هذا الإجراء لا يمكن التراجع عنه.',
  onConfirm: () => _proceed(),
);

// Danger / Delete
final confirmed = await showMyDialog<bool>(
  context: context,
  type: MyDialogType.danger,
  title: 'حذف الحساب',
  message: 'سيتم حذف حسابك نهائياً. هل أنت متأكد؟',
  onConfirm: () => _deleteAccount(),
);
if (confirmed == true) { }

// Confirm
final ok = await showMyDialog<bool>(
  context: context,
  type: MyDialogType.confirm,
  title: 'تأكيد الطلب',
  message: 'هل تريد إتمام عملية الشراء؟',
  confirmLabel: 'شراء الآن',
  onConfirm: () => _purchase(),
);

// Custom Content
showMyDialog(
  context: context,
  type: MyDialogType.custom,
  title: 'اختر اللغة',
  content: Column(
    children: [
      ListTile(title: Text('العربية'), onTap: () {}),
      ListTile(title: Text('English'), onTap: () {}),
    ],
  ),
);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BOTTOM SHEETS — showMySheet()
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// بسيط
showMySheet(
  context: context,
  title: 'خيارات',
  child: Column(
    children: [
      ListTile(leading: Icon(Icons.edit), title: Text('تعديل')),
      ListTile(leading: Icon(Icons.share), title: Text('مشاركة')),
      ListTile(leading: Icon(Icons.delete, color: Colors.red), title: Text('حذف')),
    ],
  ),
);

// Large + Scrollable
showMySheet(
  context: context,
  title: 'اختر المدينة',
  size: MySheetSize.large,
  isScrollable: true,
  child: Column(
    children: cities.map((c) =>
      ListTile(title: Text(c), onTap: () => Navigator.pop(context, c))
    ).toList(),
  ),
);

// Full screen
showMySheet(
  context: context,
  size: MySheetSize.full,
  title: 'تفاصيل الطلب',
  child: OrderDetails(),
);

*/

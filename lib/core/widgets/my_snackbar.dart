import 'package:flutter/material.dart';

// ============================================================
//  MySnackBar + MyToast — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: SnackBar + ScaffoldMessenger بجميع أشكالها
//  Import: import 'core/widgets/my_snackbar.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MySnackType {
  info, // معلومات — primary
  success, // نجاح — أخضر
  warning, // تحذير — برتقالي
  error, // خطأ — أحمر
  neutral, // محايد — رمادي
}

enum MySnackPosition {
  bottom, // أسفل ← default
  top, // أعلى
}

enum MyToastStyle {
  minimal, // أيقونة + نص فقط ← default
  pill, // حبة دواء ممتدة
  banner, // شريط كامل العرض
}

// ─────────────────────────────────────────
//  COLOR CONFIG
// ─────────────────────────────────────────

class _TypeConfig {
  final Color bg;
  final Color fg;
  final IconData icon;

  const _TypeConfig({required this.bg, required this.fg, required this.icon});
}

_TypeConfig _resolveConfig(MySnackType type, ColorScheme scheme) {
  switch (type) {
    case MySnackType.info:
      return _TypeConfig(
        bg: scheme.primary,
        fg: scheme.onPrimary,
        icon: Icons.info_outline_rounded,
      );
    case MySnackType.success:
      return _TypeConfig(
        bg: const Color(0xFF16A34A),
        fg: Colors.white,
        icon: Icons.check_circle_outline_rounded,
      );
    case MySnackType.warning:
      return _TypeConfig(
        bg: const Color(0xFFD97706),
        fg: Colors.white,
        icon: Icons.warning_amber_rounded,
      );
    case MySnackType.error:
      return _TypeConfig(
        bg: scheme.error,
        fg: scheme.onError,
        icon: Icons.error_outline_rounded,
      );
    case MySnackType.neutral:
      return _TypeConfig(
        bg: const Color(0xFF334155),
        fg: Colors.white,
        icon: Icons.info_outline_rounded,
      );
  }
}

// ─────────────────────────────────────────
//  MY SNACKBAR — الطريقة الرئيسية
// ─────────────────────────────────────────

/// عرض SnackBar — استخدمها في أي مكان عندك context
void showMySnackBar(
  BuildContext context, {
  required String message,
  MySnackType type = MySnackType.neutral,
  MySnackPosition position = MySnackPosition.bottom,
  String? actionLabel,
  VoidCallback? onAction,
  Duration duration = const Duration(seconds: 3),
  bool showIcon = true,
  bool dismissible = true,
}) {
  final scheme = Theme.of(context).colorScheme;
  final config = _resolveConfig(type, scheme);

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: position == MySnackPosition.bottom ? 16 : 0,
          top: position == MySnackPosition.top ? 16 : 0,
        ),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        dismissDirection: dismissible
            ? DismissDirection.horizontal
            : DismissDirection.none,
        content: _SnackBarContent(
          message: message,
          config: config,
          actionLabel: actionLabel,
          onAction: onAction,
          showIcon: showIcon,
        ),
      ),
    );
}

// ─────────────────────────────────────────
//  SNACKBAR CONTENT WIDGET
// ─────────────────────────────────────────

class _SnackBarContent extends StatelessWidget {
  final String message;
  final _TypeConfig config;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showIcon;

  const _SnackBarContent({
    required this.message,
    required this.config,
    this.actionLabel,
    this.onAction,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: config.bg.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showIcon) ...[
            Icon(config.icon, color: config.fg, size: 20),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: config.fg,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                onAction?.call();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: config.fg.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  actionLabel!,
                  style: TextStyle(
                    color: config.fg,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  MY TOAST — خفيف وسريع
// ─────────────────────────────────────────

/// Toast خفيف يظهر في وسط/أعلى الشاشة
void showMyToast(
  BuildContext context, {
  required String message,
  MySnackType type = MySnackType.neutral,
  MyToastStyle style = MyToastStyle.pill,
  Duration duration = const Duration(seconds: 2),
  bool showIcon = true,
}) {
  final overlay = Overlay.of(context);
  final scheme = Theme.of(context).colorScheme;
  final config = _resolveConfig(type, scheme);

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _ToastWidget(
      message: message,
      config: config,
      toastStyle: style,
      showIcon: showIcon,
      duration: duration,
      onDone: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}

// ─────────────────────────────────────────
//  TOAST WIDGET
// ─────────────────────────────────────────

class _ToastWidget extends StatefulWidget {
  final String message;
  final _TypeConfig config;
  final MyToastStyle toastStyle;
  final bool showIcon;
  final Duration duration;
  final VoidCallback onDone;

  const _ToastWidget({
    required this.message,
    required this.config,
    required this.toastStyle,
    required this.showIcon,
    required this.duration,
    required this.onDone,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _ctrl.forward();

    Future.delayed(widget.duration, () async {
      if (mounted) {
        await _ctrl.reverse();
        widget.onDone();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Center(child: _buildToastContent(context)),
        ),
      ),
    );
  }

  Widget _buildToastContent(BuildContext context) {
    switch (widget.toastStyle) {
      case MyToastStyle.banner:
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          color: widget.config.bg,
          child: Row(
            children: [
              if (widget.showIcon) ...[
                Icon(widget.config.icon, color: widget.config.fg, size: 20),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.config.fg,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

      case MyToastStyle.minimal:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.config.bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.config.bg.withOpacity(0.3),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          constraints: const BoxConstraints(maxWidth: 320),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showIcon) ...[
                Icon(widget.config.icon, color: widget.config.fg, size: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.config.fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

      case MyToastStyle.pill:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: widget.config.bg,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: widget.config.bg.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          constraints: const BoxConstraints(maxWidth: 320),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showIcon) ...[
                Icon(widget.config.icon, color: widget.config.fg, size: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.config.fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SNACKBAR — showMySnackBar()
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// أنواع جاهزة
showMySnackBar(context, message: 'تم الحفظ بنجاح',    type: MySnackType.success)
showMySnackBar(context, message: 'حدث خطأ ما',         type: MySnackType.error)
showMySnackBar(context, message: 'تحقق من الاتصال',    type: MySnackType.warning)
showMySnackBar(context, message: 'رسالة معلومات',      type: MySnackType.info)
showMySnackBar(context, message: 'تم نسخ الرابط',      type: MySnackType.neutral)

// مع زر action
showMySnackBar(
  context,
  message: 'تم حذف العنصر',
  type: MySnackType.neutral,
  actionLabel: 'تراجع',
  onAction: () => _undoDelete(),
)

// أعلى الشاشة
showMySnackBar(
  context,
  message: 'تم التحديث',
  type: MySnackType.success,
  position: MySnackPosition.top,
)

// مدة مخصصة
showMySnackBar(
  context,
  message: 'جارٍ المعالجة...',
  type: MySnackType.info,
  duration: Duration(seconds: 5),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  TOAST — showMyToast()
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Pill (حبة دواء) ← default
showMyToast(context, message: 'تم النسخ ✓')

// Minimal
showMyToast(
  context,
  message: 'تم الحفظ',
  type: MySnackType.success,
  style: MyToastStyle.minimal,
)

// Banner
showMyToast(
  context,
  message: 'لا يوجد اتصال بالإنترنت',
  type: MySnackType.error,
  style: MyToastStyle.banner,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  الفرق بين SnackBar و Toast
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

showMySnackBar  → يحتاج Scaffold · يدعم action · أسفل/أعلى
showMyToast     → Overlay مستقل · خفيف · وسط الشاشة · بدون action

*/

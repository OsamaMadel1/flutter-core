import 'package:flutter/material.dart';

// ============================================================
//  MyLoading — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: CircularProgressIndicator + Shimmer + Loading overlays
//  Import: import 'core/widgets/my_loading.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MySpinnerStyle {
  circular, // دائرة دوران ← default
  dots, // ثلاث نقاط متحركة
  pulse, // نبض
  bars, // أشرطة
}

enum MyShimmerShape {
  line, // سطر نص
  box, // مستطيل/صورة
  circle, // دائرة (avatar)
  rounded, // مستطيل بحواف ناعمة
}

// ─────────────────────────────────────────
//  1. MY SPINNER — زر / أيقونة تحميل
// ─────────────────────────────────────────

class MySpinner extends StatefulWidget {
  final MySpinnerStyle style;
  final double size;
  final Color? color;
  final double strokeWidth;

  const MySpinner({
    super.key,
    this.style = MySpinnerStyle.circular,
    this.size = 24,
    this.color,
    this.strokeWidth = 2.5,
  });

  // ── Sizes ──
  const MySpinner.small({
    super.key,
    this.color,
    this.style = MySpinnerStyle.circular,
  }) : size = 16,
       strokeWidth = 2;

  const MySpinner.medium({
    super.key,
    this.color,
    this.style = MySpinnerStyle.circular,
  }) : size = 24,
       strokeWidth = 2.5;

  const MySpinner.large({
    super.key,
    this.color,
    this.style = MySpinnerStyle.circular,
  }) : size = 40,
       strokeWidth = 3;

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> with TickerProviderStateMixin {
  late AnimationController _rotateCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _dotsCtrl;
  late AnimationController _barsCtrl;

  @override
  void initState() {
    super.initState();
    _rotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _dotsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _barsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _rotateCtrl.dispose();
    _pulseCtrl.dispose();
    _dotsCtrl.dispose();
    _barsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    switch (widget.style) {
      case MySpinnerStyle.circular:
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
            strokeWidth: widget.strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
        );

      case MySpinnerStyle.pulse:
        return AnimatedBuilder(
          animation: _pulseCtrl,
          builder: (_, __) => Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2 + _pulseCtrl.value * 0.6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: widget.size * 0.5,
                height: widget.size * 0.5,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
          ),
        );

      case MySpinnerStyle.dots:
        return AnimatedBuilder(
          animation: _dotsCtrl,
          builder: (_, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final delay = i / 3;
                final progress = (_dotsCtrl.value - delay).clamp(0.0, 1.0);
                final scale = progress < 0.5
                    ? 1.0 + progress * 0.8
                    : 1.8 - (progress - 0.5) * 0.8 * 2;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: widget.size * 0.08),
                  child: Transform.scale(
                    scale: scale.clamp(1.0, 1.8),
                    child: Container(
                      width: widget.size * 0.22,
                      height: widget.size * 0.22,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );

      case MySpinnerStyle.bars:
        return AnimatedBuilder(
          animation: _barsCtrl,
          builder: (_, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(4, (i) {
                final delay = i / 4;
                final progress = (_barsCtrl.value - delay + 1) % 1;
                final heightFactor = progress < 0.5
                    ? progress * 2
                    : 2 - progress * 2;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: widget.size * 0.04),
                  width: widget.size * 0.15,
                  height: widget.size * (0.3 + heightFactor * 0.7),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(widget.size * 0.08),
                  ),
                );
              }),
            );
          },
        );
    }
  }
}

// ─────────────────────────────────────────
//  2. MY SHIMMER — هيكل التحميل
// ─────────────────────────────────────────

class MyShimmer extends StatefulWidget {
  final double width;
  final double height;
  final MyShimmerShape shape;
  final double? borderRadius;

  const MyShimmer({
    super.key,
    required this.width,
    required this.height,
    this.shape = MyShimmerShape.rounded,
    this.borderRadius,
  });

  // ── Shortcuts ──
  const MyShimmer.line({
    Key? key,
    double width = double.infinity,
    double height = 14,
  }) : this(key: key, width: width, height: height, shape: MyShimmerShape.line);

  const MyShimmer.box({Key? key, required double width, required double height})
    : this(key: key, width: width, height: height, shape: MyShimmerShape.box);

  const MyShimmer.circle({Key? key, required double size})
    : this(key: key, width: size, height: size, shape: MyShimmerShape.circle);

  @override
  State<MyShimmer> createState() => _MyShimmerState();
}

class _MyShimmerState extends State<MyShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _anim = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double get _radius {
    if (widget.borderRadius != null) return widget.borderRadius!;
    switch (widget.shape) {
      case MyShimmerShape.circle:
        return widget.width / 2;
      case MyShimmerShape.line:
        return 6;
      case MyShimmerShape.box:
        return 0;
      case MyShimmerShape.rounded:
        return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);
    final shimmer = isDark ? const Color(0xFF4A5568) : const Color(0xFFF8FAFC);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value + 1, 0),
            colors: [base, shimmer, base],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  3. SHIMMER CARD — بطاقة shimmer جاهزة
// ─────────────────────────────────────────

class MyShimmerCard extends StatelessWidget {
  final bool showAvatar;
  final int lines;
  final double height;

  const MyShimmerCard({
    super.key,
    this.showAvatar = true,
    this.lines = 2,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showAvatar)
            Row(
              children: [
                const MyShimmer.circle(size: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyShimmer.line(width: double.infinity, height: 14),
                      const SizedBox(height: 6),
                      MyShimmer.line(width: double.infinity, height: 11),
                    ],
                  ),
                ),
              ],
            ),
          if (showAvatar && lines > 0) const SizedBox(height: 14),
          if (height > 0) ...[
            MyShimmer.box(width: double.infinity, height: height),
            const SizedBox(height: 12),
          ],
          ...List.generate(
            lines,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: MyShimmer.line(width: double.infinity, height: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  4. MY LOADING OVERLAY — يغطي الشاشة
// ─────────────────────────────────────────

class MyLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? overlayColor;
  final MySpinnerStyle spinnerStyle;

  const MyLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.overlayColor,
    this.spinnerStyle = MySpinnerStyle.circular,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: overlayColor ?? Colors.black.withOpacity(0.4),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MySpinner(style: spinnerStyle, size: 40),
                      if (message != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          message!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white70
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────
//  5. MY PAGE LOADING — صفحة تحميل كاملة
// ─────────────────────────────────────────

class MyPageLoading extends StatelessWidget {
  final String? message;
  final MySpinnerStyle style;

  const MyPageLoading({
    super.key,
    this.message,
    this.style = MySpinnerStyle.circular,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MySpinner(style: style, size: 48),
          if (message != null) ...[
            const SizedBox(height: 20),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white54
                    : const Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
  SPINNER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MySpinner()                                    // circular ← default
MySpinner(style: MySpinnerStyle.dots)
MySpinner(style: MySpinnerStyle.pulse)
MySpinner(style: MySpinnerStyle.bars)

MySpinner.small()   // 16px
MySpinner.medium()  // 24px ← default
MySpinner.large()   // 40px

// مخصص
MySpinner(size: 32, color: Colors.white, strokeWidth: 3)

// في زر
MyButton(
  label: 'حفظ',
  isLoading: _isLoading,   // ← MyButton يستخدم MySpinner داخلياً
  onPressed: _save,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SHIMMER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyShimmer.line()                // سطر نص
MyShimmer.line(width: 120)      // سطر بعرض محدد
MyShimmer.circle(size: 44)      // avatar
MyShimmer.box(width: double.infinity, height: 160)  // صورة

// بطاقة shimmer جاهزة
MyShimmerCard()
MyShimmerCard(showAvatar: false, lines: 3)
MyShimmerCard(height: 160, lines: 2)   // مع صورة

// shimmer list
ListView.builder(
  itemCount: 5,
  itemBuilder: (_, i) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: MyShimmerCard(),
  ),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  LOADING OVERLAY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyLoadingOverlay(
  isLoading: _isSubmitting,
  message: 'جارٍ الإرسال...',
  child: Scaffold(body: _myPage),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  PAGE LOADING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// في body مباشرة
body: _isLoading
  ? MyPageLoading(message: 'جارٍ التحميل...')
  : MyActualContent()

// مع FutureBuilder
FutureBuilder(
  future: _fetchData(),
  builder: (ctx, snap) {
    if (snap.connectionState == ConnectionState.waiting)
      return MyPageLoading();
    if (snap.hasError)
      return MyEmptyState.error(onRetry: _fetchData);
    return MyContent(data: snap.data);
  },
)

*/

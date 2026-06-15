import 'package:flutter/material.dart';

// ============================================================
//  MyProgress — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: LinearProgressIndicator + CircularProgressIndicator (determinate)
//  Import: import 'core/widgets/my_progress.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyProgressSize {
  sm, // نحيف
  md, // ← default
  lg, // عريض
}

// ─────────────────────────────────────────
//  1. MY PROGRESS BAR — خطي
// ─────────────────────────────────────────

class MyProgressBar extends StatelessWidget {
  final double value; // 0.0 → 1.0
  final Color? color;
  final Color? backgroundColor;
  final MyProgressSize size;
  final double? customHeight;
  final double borderRadius;
  final bool showLabel; // يعرض % داخل/خارج
  final String? label; // نص مخصص بدل %
  final bool animate;
  final Gradient? gradient;

  const MyProgressBar({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.size = MyProgressSize.md,
    this.customHeight,
    this.borderRadius = 99,
    this.showLabel = false,
    this.label,
    this.animate = true,
    this.gradient,
  });

  // ─── Named Constructors ───

  /// شريط مع نسبة بجانبه
  const MyProgressBar.withLabel({
    Key? key,
    required double value,
    Color? color,
    MyProgressSize size = MyProgressSize.md,
  }) : this(key: key, value: value, color: color, size: size, showLabel: true);

  /// شريط ملون حسب القيمة (أحمر/أصفر/أخضر)
  const MyProgressBar.status({
    Key? key,
    required double value,
    MyProgressSize size = MyProgressSize.md,
    bool showLabel = false,
  }) : this(
         key: key,
         value: value,
         size: size,
         showLabel: showLabel,
         color: null, // يُحسب في build
       );

  double _height() {
    if (customHeight != null) return customHeight!;
    switch (size) {
      case MyProgressSize.sm:
        return 4;
      case MyProgressSize.md:
        return 8;
      case MyProgressSize.lg:
        return 12;
    }
  }

  Color _resolveColor(BuildContext context, bool isStatus) {
    if (color != null) return color!;
    if (isStatus) {
      if (value < 0.3) return const Color(0xFFEF4444);
      if (value < 0.7) return const Color(0xFFF59E0B);
      return const Color(0xFF22C55E);
    }
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final h = _height();
    final clamped = value.clamp(0.0, 1.0);
    final bg =
        backgroundColor ??
        (isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06));
    final isStatus = color == null && label == null;
    final fillColor = _resolveColor(context, isStatus);

    final bar = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: h,
        color: bg,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedFractionallySizedBox(
            duration: animate
                ? const Duration(milliseconds: 500)
                : Duration.zero,
            curve: Curves.easeOut,
            widthFactor: clamped,
            child: Container(
              decoration: BoxDecoration(
                color: gradient == null ? fillColor : null,
                gradient: gradient,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ),
    );

    if (!showLabel && label == null) return bar;

    return Row(
      children: [
        Expanded(child: bar),
        const SizedBox(width: 10),
        Text(
          label ?? '${(clamped * 100).round()}%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white70 : const Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
//  Animated FractionallySizedBox helper
// ─────────────────────────────────────────

class AnimatedFractionallySizedBox extends ImplicitlyAnimatedWidget {
  final double widthFactor;
  final AlignmentGeometry alignment;
  final Widget child;

  const AnimatedFractionallySizedBox({
    super.key,
    required this.widthFactor,
    this.alignment = Alignment.centerLeft,
    required this.child,
    required super.duration,
    super.curve = Curves.linear,
  });

  @override
  AnimatedWidgetBaseState<AnimatedFractionallySizedBox> createState() =>
      _AnimatedFractionallySizedBoxState();
}

class _AnimatedFractionallySizedBoxState
    extends AnimatedWidgetBaseState<AnimatedFractionallySizedBox> {
  Tween<double>? _widthFactor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _widthFactor =
        visitor(
              _widthFactor,
              widget.widthFactor,
              (value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: (_widthFactor?.evaluate(animation) ?? widget.widthFactor)
          .clamp(0.0, 1.0),
      alignment: widget.alignment,
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────
//  2. MY CIRCULAR PROGRESS — دائري بنسبة
// ─────────────────────────────────────────

class MyCircularProgress extends StatelessWidget {
  final double value; // 0.0 → 1.0
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final Widget? center; // محتوى في المنتصف
  final bool showPercentage;
  final bool animate;
  final StrokeCap strokeCap;

  const MyCircularProgress({
    super.key,
    required this.value,
    this.size = 64,
    this.strokeWidth = 6,
    this.color,
    this.backgroundColor,
    this.center,
    this.showPercentage = false,
    this.animate = true,
    this.strokeCap = StrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fillColor = color ?? theme.colorScheme.primary;
    final bg =
        backgroundColor ??
        (isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06));
    final clamped = value.clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(bg),
              strokeCap: strokeCap,
            ),
          ),
          // Foreground progress
          TweenAnimationBuilder<double>(
            duration: animate
                ? const Duration(milliseconds: 600)
                : Duration.zero,
            curve: Curves.easeOut,
            tween: Tween(begin: 0, end: clamped),
            builder: (_, v, __) => SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: v,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(fillColor),
                strokeCap: strokeCap,
              ),
            ),
          ),
          // Center content
          center ??
              (showPercentage
                  ? Text(
                      '${(clamped * 100).round()}%',
                      style: TextStyle(
                        fontSize: size * 0.22,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    )
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  3. MY STEP PROGRESS — خطوات (Checkout/Wizard)
// ─────────────────────────────────────────

class MyStepProgress extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 0-indexed
  final List<String>? labels;
  final Color? activeColor;
  final Color? inactiveColor;

  const MyStepProgress({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.labels,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = activeColor ?? theme.colorScheme.primary;
    final inactive =
        inactiveColor ??
        (isDark
            ? Colors.white.withOpacity(0.12)
            : Colors.black.withOpacity(0.08));

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps * 2 - 1, (i) {
            if (i.isOdd) {
              // خط بين الدوائر
              final stepIndex = (i - 1) ~/ 2;
              final isCompleted = stepIndex < currentStep;
              return Expanded(
                child: Container(
                  height: 2,
                  color: isCompleted ? active : inactive,
                ),
              );
            }

            final stepIndex = i ~/ 2;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;
            final isActive = isCompleted || isCurrent;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive ? active : inactive,
                shape: BoxShape.circle,
                border: isCurrent
                    ? Border.all(color: active.withOpacity(0.3), width: 4)
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      )
                    : Text(
                        '${stepIndex + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: isActive
                              ? Colors.white
                              : (isDark ? Colors.white38 : Colors.black38),
                        ),
                      ),
              ),
            );
          }),
        ),
        if (labels != null) ...[
          const SizedBox(height: 8),
          Row(
            children: List.generate(totalSteps, (i) {
              final isActive = i <= currentStep;
              return Expanded(
                child: Text(
                  labels![i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? active
                        : (isDark ? Colors.white38 : Colors.black38),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────
//  4. MY SEGMENTED PROGRESS — أجزاء (Stories)
// ─────────────────────────────────────────

class MySegmentedProgress extends StatelessWidget {
  final int segments;
  final int currentSegment; // الجزء النشط حالياً
  final double currentProgress; // تقدم الجزء الحالي 0-1
  final Color? activeColor;
  final Color? inactiveColor;
  final double height;
  final double spacing;

  const MySegmentedProgress({
    super.key,
    required this.segments,
    required this.currentSegment,
    this.currentProgress = 0,
    this.activeColor,
    this.inactiveColor,
    this.height = 3,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final active = activeColor ?? Colors.white;
    final inactive = inactiveColor ?? Colors.white.withOpacity(0.3);

    return Row(
      children: List.generate(segments, (i) {
        double fillFactor;
        if (i < currentSegment) {
          fillFactor = 1;
        } else if (i == currentSegment) {
          fillFactor = currentProgress.clamp(0.0, 1.0);
        } else {
          fillFactor = 0;
        }

        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: spacing / 2),
            height: height,
            decoration: BoxDecoration(
              color: inactive,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fillFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  PROGRESS BAR — خطي
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyProgressBar(value: 0.65)
MyProgressBar(value: 0.65, color: Colors.green)
MyProgressBar.withLabel(value: 0.65)             // مع % بجانب
MyProgressBar.status(value: 0.25)                // أحمر/أصفر/أخضر تلقائي

// Sizes
MyProgressBar(value: 0.5, size: MyProgressSize.sm)
MyProgressBar(value: 0.5, size: MyProgressSize.md)  // ← default
MyProgressBar(value: 0.5, size: MyProgressSize.lg)

// Gradient
MyProgressBar(
  value: 0.7,
  gradient: LinearGradient(
    colors: [AppColors.primary600, AppColors.primary400],
  ),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CIRCULAR PROGRESS — دائري
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyCircularProgress(value: 0.75)
MyCircularProgress(value: 0.75, showPercentage: true)
MyCircularProgress(value: 0.75, size: 100, strokeWidth: 10, color: Colors.green)

// مع محتوى مخصص في المنتصف
MyCircularProgress(
  value: 0.6,
  size: 80,
  center: Icon(Icons.upload_rounded, color: AppColors.primary600),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STEP PROGRESS — خطوات (Checkout)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyStepProgress(
  totalSteps: 4,
  currentStep: 1,  // 0-indexed
  labels: ['السلة', 'الشحن', 'الدفع', 'تأكيد'],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SEGMENTED PROGRESS — قصص (Stories)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MySegmentedProgress(
  segments: 5,
  currentSegment: 2,
  currentProgress: 0.4,  // تقدم القصة الحالية
)

// مع AnimationController للتشغيل التلقائي
MySegmentedProgress(
  segments: stories.length,
  currentSegment: _currentStoryIndex,
  currentProgress: _storyController.value,
)

*/

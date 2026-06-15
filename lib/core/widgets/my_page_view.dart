import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  MyPageView + MyOnboarding — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography (Syne + DM Sans)
//  يستبدل: PageView + PageController + Indicators يدوية
//  Import: import 'core/widgets/my_page_view.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

enum MyIndicatorStyle {
  dots,     // نقاط عادية ← default
  line,     // خط ممتد
  jump,     // نقطة تقفز
  worm,     // دودة تتمدد
}

enum MyOnboardingLayout {
  topImage,     // صورة أعلى + نص أسفل ← default
  centered,     // كل شيء في المنتصف
  fullImage,    // صورة كاملة مع نص فوقها
  splitHalf,    // نصف صورة نصف نص
}

// ─────────────────────────────────────────
//  ONBOARDING PAGE MODEL
// ─────────────────────────────────────────

class MyOnboardingPage {
  final String title;
  final String subtitle;
  final String? emoji;
  final Widget? illustration;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;

  const MyOnboardingPage({
    required this.title,
    required this.subtitle,
    this.emoji,
    this.illustration,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
  });
}

// ─────────────────────────────────────────
//  PAGE INDICATOR — مستقل قابل للاستخدام
// ─────────────────────────────────────────

class MyPageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final MyIndicatorStyle style;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double spacing;

  const MyPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.style = MyIndicatorStyle.dots,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.spacing = 6,
  });

  @override
  Widget build(BuildContext context) {
    final primary = activeColor ?? Theme.of(context).colorScheme.primary;
    final inactive = inactiveColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white24
            : Colors.black.withOpacity(0.15));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: _width(isActive),
          height: dotSize,
          decoration: BoxDecoration(
            color: isActive ? primary : inactive,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }

  double _width(bool isActive) {
    switch (style) {
      case MyIndicatorStyle.dots:  return dotSize;
      case MyIndicatorStyle.line:  return isActive ? dotSize * 4 : dotSize;
      case MyIndicatorStyle.jump:  return isActive ? dotSize * 1.5 : dotSize;
      case MyIndicatorStyle.worm:  return isActive ? dotSize * 3 : dotSize;
    }
  }
}

// ─────────────────────────────────────────
//  MY PAGE VIEW — PageView مع مؤشرات
// ─────────────────────────────────────────

class MyPageView extends StatefulWidget {
  final List<Widget> pages;
  final PageController? controller;
  final MyIndicatorStyle indicatorStyle;
  final Color? indicatorActiveColor;
  final bool showIndicator;
  final bool enableHaptic;
  final ValueChanged<int>? onPageChanged;
  final bool physics;          // هل يمكن السحب يدوياً

  const MyPageView({
    super.key,
    required this.pages,
    this.controller,
    this.indicatorStyle = MyIndicatorStyle.dots,
    this.indicatorActiveColor,
    this.showIndicator = true,
    this.enableHaptic = true,
    this.onPageChanged,
    this.physics = true,
  });

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late PageController _ctrl;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? PageController();
    _ctrl.addListener(() {
      final page = _ctrl.page?.round() ?? 0;
      if (page != _current) {
        setState(() => _current = page);
        if (widget.enableHaptic) HapticFeedback.selectionClick();
        widget.onPageChanged?.call(page);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _ctrl,
            physics: widget.physics
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            children: widget.pages,
          ),
        ),
        if (widget.showIndicator) ...[
          const SizedBox(height: 16),
          MyPageIndicator(
            count: widget.pages.length,
            currentIndex: _current,
            style: widget.indicatorStyle,
            activeColor: widget.indicatorActiveColor,
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────
//  MY ONBOARDING — شاشات الترحيب الكاملة
// ─────────────────────────────────────────

class MyOnboarding extends StatefulWidget {
  final List<MyOnboardingPage> pages;
  final VoidCallback onDone;
  final VoidCallback? onSkip;
  final String doneLabel;
  final String nextLabel;
  final String skipLabel;
  final MyIndicatorStyle indicatorStyle;
  final MyOnboardingLayout layout;
  final bool showSkip;
  final Color? primaryColor;
  final bool enableHaptic;

  const MyOnboarding({
    super.key,
    required this.pages,
    required this.onDone,
    this.onSkip,
    this.doneLabel = 'ابدأ الآن',
    this.nextLabel = 'التالي',
    this.skipLabel = 'تخطي',
    this.indicatorStyle = MyIndicatorStyle.worm,
    this.layout = MyOnboardingLayout.topImage,
    this.showSkip = true,
    this.primaryColor,
    this.enableHaptic = true,
  });

  @override
  State<MyOnboarding> createState() => _MyOnboardingState();
}

class _MyOnboardingState extends State<MyOnboarding> {
  late PageController _ctrl;
  int _current = 0;

  bool get _isLast => _current == widget.pages.length - 1;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (widget.enableHaptic) HapticFeedback.lightImpact();
    if (_isLast) {
      widget.onDone();
    } else {
      _ctrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    if (widget.enableHaptic) HapticFeedback.lightImpact();
    widget.onSkip?.call();
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = widget.primaryColor ?? theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: widget.pages[_current].backgroundColor ??
          (isDark ? const Color(0xFF0F172A) : Colors.white),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // indicator
                  MyPageIndicator(
                    count: widget.pages.length,
                    currentIndex: _current,
                    style: widget.indicatorStyle,
                    activeColor: primary,
                    dotSize: 7,
                  ),
                  // skip
                  if (widget.showSkip && !_isLast)
                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        widget.skipLabel,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
            ),

            // ── Pages ──
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                onPageChanged: (i) {
                  setState(() => _current = i);
                  if (widget.enableHaptic) HapticFeedback.selectionClick();
                },
                itemCount: widget.pages.length,
                itemBuilder: (_, i) =>
                    _buildPage(widget.pages[i], primary, isDark),
              ),
            ),

            // ── Bottom Button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  key: ValueKey(_isLast),
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: primary.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLast ? widget.doneLabel : widget.nextLabel,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        if (!_isLast) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(MyOnboardingPage page, Color primary, bool isDark) {
    final titleColor = page.titleColor ??
        (isDark ? Colors.white : const Color(0xFF0F172A));
    final subtitleColor = page.subtitleColor ??
        (isDark ? Colors.white60 : const Color(0xFF64748B));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Illustration / Emoji ──
          if (page.illustration != null) ...[
            page.illustration!,
            const SizedBox(height: 40),
          ] else if (page.emoji != null) ...[
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  page.emoji!,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],

          // ── Title ──
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: titleColor,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),

          // ── Subtitle ──
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: subtitleColor,
              height: 1.7,
              fontWeight: FontWeight.w400,
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
  INDICATOR — مستقل
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyPageIndicator(count: 4, currentIndex: _page)
MyPageIndicator(count: 4, currentIndex: _page, style: MyIndicatorStyle.worm)
MyPageIndicator(count: 4, currentIndex: _page, style: MyIndicatorStyle.line)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  PAGE VIEW — مع مؤشرات
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyPageView(
  indicatorStyle: MyIndicatorStyle.worm,
  pages: [
    ProductPage(product: p1),
    ProductPage(product: p2),
    ProductPage(product: p3),
  ],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ONBOARDING — شاشات الترحيب
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// في main أو Router
if (!_onboardingDone)
  MyOnboarding(
    onDone: () => _completeOnboarding(),
    onSkip: () => _completeOnboarding(),
    pages: const [
      MyOnboardingPage(
        emoji: '👋',
        title: 'أهلاً بك في التطبيق',
        subtitle: 'اكتشف كل ما يقدمه لك التطبيق من مميزات رائعة',
      ),
      MyOnboardingPage(
        emoji: '⚡',
        title: 'سريع وسهل الاستخدام',
        subtitle: 'واجهة مصممة خصيصاً لتجربة مستخدم استثنائية',
      ),
      MyOnboardingPage(
        emoji: '🔒',
        title: 'آمن وخصوصيتك محمية',
        subtitle: 'بياناتك مشفرة وآمنة في جميع الأوقات',
      ),
    ],
  )

// مع SharedPreferences
Future<void> _completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_done', true);
  if (mounted) context.go('/home');
}

// مع Riverpod
final onboardingDoneProvider = StateProvider<bool>((ref) => false);

MyOnboarding(
  onDone: () {
    ref.read(onboardingDoneProvider.notifier).state = true;
    context.go('/home');
  },
  pages: [...],
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  INDICATOR STYLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyIndicatorStyle.dots   // ● ○ ○ ○
MyIndicatorStyle.line   // ━━ ─ ─ ─
MyIndicatorStyle.jump   // ⬤ ○ ○ ○  (أكبر)
MyIndicatorStyle.worm   // ━━━ ─ ─   (يتمدد)

*/

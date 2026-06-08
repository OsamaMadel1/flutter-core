import 'package:flutter/material.dart';

// ============================================================
//  MyAvatar — Widget مرجعي شامل
//  متوافق مع: AppColors · AppTheme · AppTypography
//  يستبدل: CircleAvatar + كل أشكال الصور الشخصية
//  Import: import 'core/widgets/my_avatar.dart';
// ============================================================

// ─────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────

/// شكل الـ Avatar
enum MyAvatarShape {
  circle,    // دائري ← default
  rounded,   // مستطيل بحواف ناعمة
  square,    // مربع حاد
}

/// حجم الـ Avatar
enum MyAvatarSize {
  xs,   // 24px
  sm,   // 32px
  md,   // 48px ← default
  lg,   // 64px
  xl,   // 96px
  xxl,  // 128px
}

/// موضع الـ Badge (نقطة الحالة)
enum MyAvatarBadgePosition {
  topRight,
  topLeft,
  bottomRight,  // ← default
  bottomLeft,
}

/// حالة المستخدم
enum MyAvatarStatus {
  online,
  offline,
  away,
  busy,
  none,
}

// ─────────────────────────────────────────
//  MAIN WIDGET
// ─────────────────────────────────────────

class MyAvatar extends StatelessWidget {
  // ── الصورة ──
  final String? imageUrl;          // رابط صورة شبكة
  final String? assetPath;         // صورة محلية
  final ImageProvider? imageProvider; // أي ImageProvider

  // ── Fallback ──
  final String? name;              // لعرض الأحرف الأولى
  final IconData? fallbackIcon;    // أيقونة بديلة عند غياب الاسم
  final Color? backgroundColor;   // خلفية الـ initials

  // ── المظهر ──
  final MyAvatarSize size;
  final MyAvatarShape shape;
  final double? customSize;        // حجم مخصص يتجاوز MyAvatarSize

  // ── الحدود ──
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;

  // ── Badge الحالة ──
  final MyAvatarStatus status;
  final MyAvatarBadgePosition badgePosition;
  final Widget? customBadge;       // badge مخصص (عدد الإشعارات مثلاً)

  // ── التفاعل ──
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  // ── تحميل ──
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const MyAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.imageProvider,
    this.name,
    this.fallbackIcon,
    this.backgroundColor,
    this.size = MyAvatarSize.md,
    this.shape = MyAvatarShape.circle,
    this.customSize,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 2.5,
    this.status = MyAvatarStatus.none,
    this.badgePosition = MyAvatarBadgePosition.bottomRight,
    this.customBadge,
    this.onTap,
    this.onLongPress,
    this.loadingWidget,
    this.errorWidget,
  });

  // ─── Named Constructors ───

  /// Avatar مع حالة online/offline
  const MyAvatar.withStatus({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.imageProvider,
    this.name,
    this.fallbackIcon,
    this.backgroundColor,
    this.size = MyAvatarSize.md,
    this.shape = MyAvatarShape.circle,
    this.customSize,
    required this.status,
    this.badgePosition = MyAvatarBadgePosition.bottomRight,
    this.onTap,
    this.loadingWidget,
    this.errorWidget,
  })  : showBorder = false,
        borderColor = null,
        borderWidth = 2.5,
        customBadge = null,
        onLongPress = null;

  /// Avatar مع حدود (مناسب للـ story style)
  const MyAvatar.bordered({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.imageProvider,
    this.name,
    this.fallbackIcon,
    this.backgroundColor,
    this.size = MyAvatarSize.lg,
    this.shape = MyAvatarShape.circle,
    this.customSize,
    this.borderColor,
    this.borderWidth = 3,
    this.onTap,
    this.loadingWidget,
    this.errorWidget,
  })  : showBorder = true,
        status = MyAvatarStatus.none,
        badgePosition = MyAvatarBadgePosition.bottomRight,
        customBadge = null,
        onLongPress = null;

  /// Avatar صغير للـ comments / lists
  const MyAvatar.small({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.name,
    this.backgroundColor,
    this.onTap,
  })  : imageProvider = null,
        fallbackIcon = null,
        size = MyAvatarSize.sm,
        shape = MyAvatarShape.circle,
        customSize = null,
        showBorder = false,
        borderColor = null,
        borderWidth = 2,
        status = MyAvatarStatus.none,
        badgePosition = MyAvatarBadgePosition.bottomRight,
        customBadge = null,
        loadingWidget = null,
        errorWidget = null,
        onLongPress = null;

  /// Avatar كبير لصفحة البروفايل
  const MyAvatar.profile({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.name,
    this.backgroundColor,
    this.showBorder = true,
    this.borderColor,
    this.onTap,
    this.onLongPress,
  })  : imageProvider = null,
        fallbackIcon = Icons.camera_alt_outlined,
        size = MyAvatarSize.xxl,
        shape = MyAvatarShape.circle,
        customSize = null,
        borderWidth = 3,
        status = MyAvatarStatus.none,
        badgePosition = MyAvatarBadgePosition.bottomRight,
        customBadge = null,
        loadingWidget = null,
        errorWidget = null;

  // ─── Size Resolution ───
  double get _resolvedSize {
    if (customSize != null) return customSize!;
    switch (size) {
      case MyAvatarSize.xs:  return 24;
      case MyAvatarSize.sm:  return 32;
      case MyAvatarSize.md:  return 48;
      case MyAvatarSize.lg:  return 64;
      case MyAvatarSize.xl:  return 96;
      case MyAvatarSize.xxl: return 128;
    }
  }

  double get _badgeSize {
    if (_resolvedSize <= 32) return 8;
    if (_resolvedSize <= 48) return 11;
    if (_resolvedSize <= 64) return 13;
    return 16;
  }

  double get _fontSize => _resolvedSize * 0.36;

  double get _borderRadius {
    switch (shape) {
      case MyAvatarShape.circle:  return _resolvedSize / 2;
      case MyAvatarShape.rounded: return _resolvedSize * 0.22;
      case MyAvatarShape.square:  return 4;
    }
  }

  // ─── Initials from name ───
  String _getInitials() {
    if (name == null || name!.trim().isEmpty) return '';
    final parts = name!.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  // ─── Background Color from initials ───
  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;
    final scheme = Theme.of(context).colorScheme;
    if (name == null || name!.isEmpty) return scheme.primary.withOpacity(0.15);

    // لون ثابت بناءً على اسم المستخدم
    final colors = [
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      const Color(0xFF7C3AED),
      const Color(0xFF059669),
      const Color(0xFFDC2626),
      const Color(0xFFD97706),
      const Color(0xFF0891B2),
    ];
    final index = name!.codeUnits.fold(0, (a, b) => a + b) % colors.length;
    return colors[index];
  }

  // ─── Status Color ───
  Color _statusColor() {
    switch (status) {
      case MyAvatarStatus.online:  return const Color(0xFF22C55E);
      case MyAvatarStatus.offline: return const Color(0xFF94A3B8);
      case MyAvatarStatus.away:    return const Color(0xFFFBBF24);
      case MyAvatarStatus.busy:    return const Color(0xFFEF4444);
      case MyAvatarStatus.none:    return Colors.transparent;
    }
  }

  // ─── Badge Position ───
  AlignmentGeometry get _badgeAlignment {
    switch (badgePosition) {
      case MyAvatarBadgePosition.topRight:    return Alignment.topRight;
      case MyAvatarBadgePosition.topLeft:     return Alignment.topLeft;
      case MyAvatarBadgePosition.bottomRight: return Alignment.bottomRight;
      case MyAvatarBadgePosition.bottomLeft:  return Alignment.bottomLeft;
    }
  }

  // ─── Image Widget ───
  Widget _buildImage(BuildContext context) {
    final d = _resolvedSize;
    final bg = _getBackgroundColor(context);
    final initials = _getInitials();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine image source
    ImageProvider? provider;
    if (imageProvider != null) {
      provider = imageProvider;
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    } else if (assetPath != null && assetPath!.isNotEmpty) {
      provider = AssetImage(assetPath!);
    }

    Widget content;

    if (provider != null) {
      content = Image(
        image: provider,
        width: d,
        height: d,
        fit: BoxFit.cover,
        loadingBuilder: (ctx, child, progress) {
          if (progress == null) return child;
          return loadingWidget ??
              Container(
                color: bg.withOpacity(0.3),
                child: Center(
                  child: SizedBox(
                    width: d * 0.3,
                    height: d * 0.3,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: bg,
                    ),
                  ),
                ),
              );
        },
        errorBuilder: (ctx, err, stack) {
          return errorWidget ?? _buildFallback(context, bg, initials, isDark);
        },
      );
    } else {
      content = _buildFallback(context, bg, initials, isDark);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(width: d, height: d, child: content),
    );
  }

  Widget _buildFallback(
      BuildContext context, Color bg, String initials, bool isDark) {
    final d = _resolvedSize;
    return Container(
      width: d,
      height: d,
      color: bg.withOpacity(isDark ? 0.3 : 0.15),
      child: initials.isNotEmpty
          ? Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.w700,
                  color: bg,
                  letterSpacing: 0.5,
                ),
              ),
            )
          : Center(
              child: Icon(
                fallbackIcon ?? Icons.person_rounded,
                size: d * 0.5,
                color: bg,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = _resolvedSize;
    final scheme = Theme.of(context).colorScheme;
    final borderCol = borderColor ?? scheme.primary;

    Widget avatar = _buildImage(context);

    // ── Border ──
    if (showBorder) {
      avatar = Container(
        width: d + borderWidth * 2,
        height: d + borderWidth * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius + borderWidth),
          border: Border.all(color: borderCol, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: avatar,
        ),
      );
    }

    // ── Badge ──
    final hasBadge = status != MyAvatarStatus.none || customBadge != null;
    if (hasBadge) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned.fill(
            child: Align(
              alignment: _badgeAlignment,
              child: customBadge ??
                  Container(
                    width: _badgeSize,
                    height: _badgeSize,
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: _badgeSize > 10 ? 2 : 1.5,
                      ),
                    ),
                  ),
            ),
          ),
        ],
      );
    }

    // ── Tap ──
    if (onTap != null || onLongPress != null) {
      avatar = GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: avatar,
      );
    }

    return avatar;
  }
}

// ─────────────────────────────────────────
//  AVATAR GROUP — عرض مجموعة avatars متداخلة
// ─────────────────────────────────────────

class MyAvatarGroup extends StatelessWidget {
  final List<MyAvatar> avatars;
  final int maxVisible;          // أقصى عدد يظهر ← default 4
  final double overlap;          // مقدار التداخل ← default 12
  final MyAvatarSize size;
  final VoidCallback? onMoreTap;

  const MyAvatarGroup({
    super.key,
    required this.avatars,
    this.maxVisible = 4,
    this.overlap = 12,
    this.size = MyAvatarSize.sm,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visible = avatars.take(maxVisible).toList();
    final extra = avatars.length - maxVisible;

    // حجم الـ avatar
    double avatarSize;
    switch (size) {
      case MyAvatarSize.xs:  avatarSize = 24; break;
      case MyAvatarSize.sm:  avatarSize = 32; break;
      case MyAvatarSize.md:  avatarSize = 48; break;
      case MyAvatarSize.lg:  avatarSize = 64; break;
      case MyAvatarSize.xl:  avatarSize = 96; break;
      case MyAvatarSize.xxl: avatarSize = 128; break;
    }

    final totalWidth = avatarSize +
        (visible.length - 1) * (avatarSize - overlap) +
        (extra > 0 ? (avatarSize - overlap) : 0);

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        children: [
          ...visible.asMap().entries.map((e) {
            return Positioned(
              left: e.key * (avatarSize - overlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: MyAvatar(
                  imageUrl: e.value.imageUrl,
                  assetPath: e.value.assetPath,
                  name: e.value.name,
                  size: size,
                ),
              ),
            );
          }),
          if (extra > 0)
            Positioned(
              left: visible.length * (avatarSize - overlap),
              child: GestureDetector(
                onTap: onMoreTap,
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.primary.withOpacity(0.12),
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+$extra',
                      style: TextStyle(
                        fontSize: avatarSize * 0.28,
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
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

// ============================================================
//  USAGE REFERENCE
// ============================================================
/*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  BASIC
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// صورة من الشبكة
MyAvatar(imageUrl: 'https://...')

// أحرف الاسم (Initials) — لون تلقائي
MyAvatar(name: 'أسامة العمري')

// أيقونة افتراضية
MyAvatar(fallbackIcon: Icons.person)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  NAMED CONSTRUCTORS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// مع حالة
MyAvatar.withStatus(
  imageUrl: user.photo,
  name: user.name,
  status: MyAvatarStatus.online,
)

// حدود story-style
MyAvatar.bordered(
  imageUrl: user.photo,
  borderColor: Colors.blue,
  size: MyAvatarSize.lg,
  onTap: _openStory,
)

// بروفايل
MyAvatar.profile(
  imageUrl: user.photo,
  name: user.name,
  onLongPress: _changePhoto,
)

// صغير للقوائم
MyAvatar.small(name: 'محمد', onTap: _openProfile)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SIZES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAvatar(name: 'أ ع', size: MyAvatarSize.xs)   // 24
MyAvatar(name: 'أ ع', size: MyAvatarSize.sm)   // 32
MyAvatar(name: 'أ ع', size: MyAvatarSize.md)   // 48 ← default
MyAvatar(name: 'أ ع', size: MyAvatarSize.lg)   // 64
MyAvatar(name: 'أ ع', size: MyAvatarSize.xl)   // 96
MyAvatar(name: 'أ ع', size: MyAvatarSize.xxl)  // 128

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SHAPES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAvatar(name: 'أ ع', shape: MyAvatarShape.circle)   // ← default
MyAvatar(name: 'أ ع', shape: MyAvatarShape.rounded)
MyAvatar(name: 'أ ع', shape: MyAvatarShape.square)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  STATUS BADGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAvatar(name: 'أ ع', status: MyAvatarStatus.online)
MyAvatar(name: 'أ ع', status: MyAvatarStatus.offline)
MyAvatar(name: 'أ ع', status: MyAvatarStatus.away)
MyAvatar(name: 'أ ع', status: MyAvatarStatus.busy)

// Badge مخصص (إشعارات)
MyAvatar(
  name: 'أ ع',
  customBadge: Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
  ),
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  AVATAR GROUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MyAvatarGroup(
  avatars: users.map((u) => MyAvatar(
    imageUrl: u.photo,
    name: u.name,
  )).toList(),
  maxVisible: 4,
  onMoreTap: _showAllMembers,
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  في ListTile / Chat
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ListTile(
  leading: MyAvatar.withStatus(
    imageUrl: contact.photo,
    name: contact.name,
    status: contact.isOnline
        ? MyAvatarStatus.online
        : MyAvatarStatus.offline,
  ),
  title: Text(contact.name),
  subtitle: Text(contact.lastMessage),
)

*/

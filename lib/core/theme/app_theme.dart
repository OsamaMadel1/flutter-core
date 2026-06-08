import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// 🎨 AppTheme — Light & Dark ThemeData
abstract class AppTheme {
  // ─── Shared Constants ─────────────────────────────────────
  static const _borderRadius = 12.0;
  static const _inputRadius = 10.0;

  // ═══════════════════════════════════════════════════════════
  //  LIGHT THEME
  // ═══════════════════════════════════════════════════════════
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTypography.lightTextTheme,

    // ── Color Scheme ─────────────────────────────────────────
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary600,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primary100,
      onPrimaryContainer: AppColors.primary900,

      secondary: AppColors.primary400,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.primary50,
      onSecondaryContainer: AppColors.primary800,

      tertiary: AppColors.primary300,
      onTertiary: AppColors.primary900,

      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.infoBg,
      onErrorContainer: AppColors.error,

      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightSubtext,

      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorderSubtle,
      shadow: AppColors.black,
      scrim: AppColors.overlayLight,
      inverseSurface: AppColors.darkSurface,
      onInverseSurface: AppColors.darkOnSurface,
      inversePrimary: AppColors.primary300,
    ),

    // ── Scaffold ──────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.lightBackground,

    // ── AppBar ────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightOnBackground,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.lightBorder,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTypography.lightTextTheme.titleLarge,
      iconTheme: const IconThemeData(
        color: AppColors.lightOnBackground,
        size: 24,
      ),
    ),

    // ── Card ──────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: const BorderSide(color: AppColors.lightBorderSubtle, width: 1),
      ),
      margin: const EdgeInsets.all(0),
    ),

    // ── ElevatedButton ────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.lightDisabled,
        disabledForegroundColor: AppColors.white,
        elevation: 0,
        shadowColor: AppColors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.lightTextTheme.labelLarge,
      ),
    ),

    // ── OutlinedButton ────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary600,
        side: const BorderSide(color: AppColors.primary300, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.lightTextTheme.labelLarge,
      ),
    ),

    // ── TextButton ────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary600,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.lightTextTheme.labelLarge,
      ),
    ),

    // ── FloatingActionButton ──────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary600,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // ── InputDecoration ───────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.lightBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.lightBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.primary500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: AppTypography.lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.lightDisabled,
      ),
      labelStyle: AppTypography.lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.lightSubtext,
      ),
      floatingLabelStyle: AppTypography.lightTextTheme.bodySmall?.copyWith(
        color: AppColors.primary600,
      ),
    ),

    // ── BottomNavigationBar ───────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.primary600,
      unselectedItemColor: AppColors.lightSubtext,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // ── NavigationBar (M3) ────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      indicatorColor: AppColors.primary100,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary700, size: 24);
        }
        return const IconThemeData(color: AppColors.lightSubtext, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.lightTextTheme.labelSmall?.copyWith(
            color: AppColors.primary700,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.lightTextTheme.labelSmall?.copyWith(
          color: AppColors.lightSubtext,
        );
      }),
    ),

    // ── Chip ──────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primary50,
      selectedColor: AppColors.primary100,
      labelStyle: AppTypography.lightTextTheme.labelMedium?.copyWith(
        color: AppColors.primary700,
      ),
      side: const BorderSide(color: AppColors.primary200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── Dialog ────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: AppTypography.lightTextTheme.headlineSmall,
      contentTextStyle: AppTypography.lightTextTheme.bodyMedium,
    ),

    // ── SnackBar ──────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary900,
      contentTextStyle: AppTypography.lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.white,
      ),
      actionTextColor: AppColors.primary300,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),

    // ── Switch ────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.white
            : AppColors.lightSubtext,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.primary500
            : AppColors.lightBorder,
      ),
    ),

    // ── Checkbox ──────────────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.primary600
            : AppColors.transparent,
      ),
      side: const BorderSide(color: AppColors.lightBorder, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── Divider ───────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.lightDivider,
      thickness: 1,
      space: 1,
    ),

    // ── ProgressIndicator ─────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary600,
      linearTrackColor: AppColors.primary100,
      circularTrackColor: AppColors.primary100,
    ),

    // ── Slider ────────────────────────────────────────────────
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.primary600,
      inactiveTrackColor: AppColors.primary100,
      thumbColor: AppColors.primary600,
      overlayColor: AppColors.accentGlowLight,
    ),

    // ── TabBar ────────────────────────────────────────────────
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary600,
      unselectedLabelColor: AppColors.lightSubtext,
      indicatorColor: AppColors.primary600,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppTypography.lightTextTheme.labelLarge,
      unselectedLabelStyle: AppTypography.lightTextTheme.labelMedium,
    ),

    // ── ListTile ──────────────────────────────────────────────
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      tileColor: AppColors.transparent,
    ),
  );

  // ═══════════════════════════════════════════════════════════
  //  DARK THEME
  // ═══════════════════════════════════════════════════════════
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: AppTypography.darkTextTheme,

    // ── Color Scheme ─────────────────────────────────────────
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary500,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primary800,
      onPrimaryContainer: AppColors.primary100,

      secondary: AppColors.primary400,
      onSecondary: AppColors.darkBackground,
      secondaryContainer: Color(0x333B82F6), // primary500@20%
      onSecondaryContainer: AppColors.primary200,

      tertiary: AppColors.primary300,
      onTertiary: AppColors.darkBackground,

      error: AppColors.errorDark,
      onError: AppColors.darkBackground,
      errorContainer: Color(0x1AF87171),
      onErrorContainer: AppColors.errorDark,

      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkSubtext,

      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorderSubtle,
      shadow: AppColors.black,
      scrim: AppColors.overlayDark,
      inverseSurface: AppColors.lightSurface,
      onInverseSurface: AppColors.lightOnSurface,
      inversePrimary: AppColors.primary600,
    ),

    // ── Scaffold ──────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.darkBackground,

    // ── AppBar ────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnBackground,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.darkBorder,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: AppTypography.darkTextTheme.titleLarge,
      iconTheme: const IconThemeData(
        color: AppColors.darkOnBackground,
        size: 24,
      ),
    ),

    // ── Card ──────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: const BorderSide(color: AppColors.darkBorderSubtle, width: 1),
      ),
      margin: const EdgeInsets.all(0),
    ),

    // ── ElevatedButton ────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.darkDisabled,
        disabledForegroundColor: AppColors.darkSubtext,
        elevation: 0,
        shadowColor: AppColors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.darkTextTheme.labelLarge,
      ),
    ),

    // ── OutlinedButton ────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary400,
        side: const BorderSide(color: AppColors.primary700, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.darkTextTheme.labelLarge,
      ),
    ),

    // ── TextButton ────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        textStyle: AppTypography.darkTextTheme.labelLarge,
      ),
    ),

    // ── FloatingActionButton ──────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary500,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // ── InputDecoration ───────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.darkBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.darkBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.primary500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.errorDark, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
      ),
      hintStyle: AppTypography.darkTextTheme.bodyMedium?.copyWith(
        color: AppColors.darkDisabled,
      ),
      labelStyle: AppTypography.darkTextTheme.bodyMedium?.copyWith(
        color: AppColors.darkSubtext,
      ),
      floatingLabelStyle: AppTypography.darkTextTheme.bodySmall?.copyWith(
        color: AppColors.primary400,
      ),
    ),

    // ── BottomNavigationBar ───────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary400,
      unselectedItemColor: AppColors.darkSubtext,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // ── NavigationBar (M3) ────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      indicatorColor: const Color(0x333B82F6),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary400, size: 24);
        }
        return const IconThemeData(color: AppColors.darkSubtext, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.darkTextTheme.labelSmall?.copyWith(
            color: AppColors.primary400,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.darkTextTheme.labelSmall?.copyWith(
          color: AppColors.darkSubtext,
        );
      }),
    ),

    // ── Chip ──────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0x1A3B82F6),
      selectedColor: const Color(0x333B82F6),
      labelStyle: AppTypography.darkTextTheme.labelMedium?.copyWith(
        color: AppColors.primary300,
      ),
      side: const BorderSide(color: AppColors.primary800),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── Dialog ────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.darkBorder, width: 1),
      ),
      titleTextStyle: AppTypography.darkTextTheme.headlineSmall,
      contentTextStyle: AppTypography.darkTextTheme.bodyMedium,
    ),

    // ── SnackBar ──────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurfaceVariant,
      contentTextStyle: AppTypography.darkTextTheme.bodyMedium?.copyWith(
        color: AppColors.darkOnBackground,
      ),
      actionTextColor: AppColors.primary400,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
    ),

    // ── Switch ────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.white
            : AppColors.darkSubtext,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.primary500
            : AppColors.darkBorder,
      ),
    ),

    // ── Checkbox ──────────────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.primary500
            : AppColors.transparent,
      ),
      side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── Divider ───────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
      space: 1,
    ),

    // ── ProgressIndicator ─────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary500,
      linearTrackColor: Color(0x1A3B82F6),
      circularTrackColor: Color(0x1A3B82F6),
    ),

    // ── Slider ────────────────────────────────────────────────
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.primary500,
      inactiveTrackColor: Color(0x1A3B82F6),
      thumbColor: AppColors.primary400,
      overlayColor: AppColors.accentGlowDark,
    ),

    // ── TabBar ────────────────────────────────────────────────
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary400,
      unselectedLabelColor: AppColors.darkSubtext,
      indicatorColor: AppColors.primary400,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppTypography.darkTextTheme.labelLarge,
      unselectedLabelStyle: AppTypography.darkTextTheme.labelMedium,
    ),

    // ── ListTile ──────────────────────────────────────────────
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      tileColor: AppColors.transparent,
    ),
  );
}

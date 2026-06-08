/// 🎨 App Colors - All Color Systems
/// ============================================================
/// استيراد سهل لجميع نظم الألوان المتاحة
///
/// الاستخدام:
/// - استخدم: `AppColorsBlue` أو `AppColorsRed` أو أي نظام آخر
/// - للتبديل السريع: غيّر الاستيراد الافتراضي في `app_colors.dart`
/// ============================================================

export 'colors/colors_blue.dart';
export 'colors/colors_red.dart';
export 'colors/colors_green.dart';
export 'colors/colors_yellow.dart';
export 'colors/colors_orange.dart';
export 'colors/colors_purple.dart';
export 'colors/colors_pink.dart';
export 'colors/colors_brown.dart';
export 'colors/colors_beige.dart';

// ┌────────────────────────────────────────────────────────┐
// │ الإعدادات الافتراضية - استخدم AppColors في مشروعك    │
// │ غيّر الاستيراد التالي للتبديل بين الأنظمة              │
// └────────────────────────────────────────────────────────┘

// استيراد النظام الافتراضي (أزرق)
export 'colors/colors_blue.dart' show AppColorsBlue;

// export 'colors/colors_red.dart' show AppColorsRed;
// export 'colors/colors_green.dart' show AppColorsGreen;
// export 'colors/colors_orange.dart' show AppColorsOrange;
// export 'colors/colors_purple.dart' show AppColorsPurple;
// export 'colors/colors_yellow.dart' show AppColorsYellow;
// export 'colors/colors_brown.dart' show AppColorsBrown;
// export 'colors/colors_pink.dart' show AppColorsPink;
// export 'colors/colors_beige.dart' show AppColorsBeige;

// إذا أردت استخدام نظام آخر افتراضياً:
// 1. أضفْ هذا التعريف
// 2. استبدل AppColorsBlue بـ AppColorsRed (أو أي لون آخر)
// 3. استخدم AppColors في كل التطبيق

// مثال - إذا كنت تريد الأحمر:
// typedef AppColors = AppColorsRed;

// أو للمزيد من المرونة، استخدم:
// abstract class AppColors extends AppColorsBlue {}

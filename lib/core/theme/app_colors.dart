///  App Colors - Default Color System
/// ============================================================
/// ملف موجه للنظام الافتراضي (أزرق)
///
/// لتغيير النظام الافتراضي:
/// 1. استبدل السطر التالي بـ:
///    `import 'colors_red.dart' as colors show AppColorsRed;`
/// 2. غيّر آخر سطر إلى: `typedef AppColors = colors.AppColorsRed;`
/// ============================================================

import 'colors/colors_blue.dart' as colors show AppColorsBlue;
// import 'colors/colors_red.dart' as colors show AppColorsRed;
// import 'colors/colors_green.dart' as colors show AppColorsGreen;
// import 'colors/colors_orange.dart' as colors show AppColorsOrange;
// import 'colors/colors_purple.dart' as colors show AppColorsPurple;
// import 'colors/colors_yellow.dart' as colors show AppColorsYellow;
// import 'colors/colors_brown.dart' as colors show AppColorsBrown;
// import 'colors/colors_pink.dart' as colors show AppColorsPink;
// import 'colors/colors_beige.dart' as colors show AppColorsBeige;

/// استخدم هذا في كل التطبيق
typedef AppColors = colors.AppColorsBlue;

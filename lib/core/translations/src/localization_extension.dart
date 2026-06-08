import 'package:flutter/material.dart';
import 'generated/app_localizations.dart';

/// Easy access to localized strings via BuildContext
///
/// Usage:
///   context.tr.appName
///   context.tr.welcomeBack('Ahmed')
extension LocalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);
}

/// Easy access to locale info via BuildContext
extension LocaleExtension on BuildContext {
  Locale get currentLocale => Localizations.localeOf(this);
  bool get isArabic => currentLocale.languageCode == 'ar';
  bool get isEnglish => currentLocale.languageCode == 'en';
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}

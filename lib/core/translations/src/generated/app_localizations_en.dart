// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'My App';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get retry => 'Retry';

  @override
  String get refresh => 'Refresh';

  @override
  String get search => 'Search';

  @override
  String get clear => 'Clear';

  @override
  String get submit => 'Submit';

  @override
  String get continueText => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get loading => 'Loading...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get noData => 'No data available';

  @override
  String get noResults => 'No results found';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Information';

  @override
  String get generalError => 'Something went wrong. Please try again.';

  @override
  String get networkError =>
      'No internet connection. Please check your network.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get timeoutError => 'Request timed out. Please try again.';

  @override
  String get unauthorizedError => 'Session expired. Please login again.';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get username => 'Username';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Register';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get messages => 'Messages';

  @override
  String get favorites => 'Favorites';

  @override
  String get history => 'History';

  @override
  String get help => 'Help';

  @override
  String get about => 'About';

  @override
  String get terms => 'Terms of Service';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get contact => 'Contact Us';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemTheme => 'System Default';

  @override
  String get fontSize => 'Font Size';

  @override
  String get notifications_settings => 'Notification Settings';

  @override
  String get account => 'Account';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String welcomeBack(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String notificationsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notifications',
      one: '1 notification',
      zero: 'No notifications',
    );
    return '$_temp0';
  }

  @override
  String deleteConfirmation(String item) {
    return 'Are you sure you want to delete $item?';
  }

  @override
  String lastUpdated(String date) {
    return 'Last updated: $date';
  }
}

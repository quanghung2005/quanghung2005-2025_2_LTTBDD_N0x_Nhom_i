import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @app_title.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc Thuốc'**
  String get app_title;

  /// No description provided for @nav_home.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get nav_home;

  /// No description provided for @nav_medicines.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách'**
  String get nav_medicines;

  /// No description provided for @nav_settings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get nav_settings;

  /// No description provided for @nav_about.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin Nhóm'**
  String get nav_about;

  /// No description provided for @hello_user.
  ///
  /// In vi, this message translates to:
  /// **'Chào bạn,'**
  String get hello_user;

  /// No description provided for @today_summary.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có {count} liều thuốc hôm nay'**
  String today_summary(int count);

  /// No description provided for @no_meds_today.
  ///
  /// In vi, this message translates to:
  /// **'Không có lịch uống thuốc nào.'**
  String get no_meds_today;

  /// No description provided for @status_taken.
  ///
  /// In vi, this message translates to:
  /// **'Đã uống'**
  String get status_taken;

  /// No description provided for @status_skipped.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get status_skipped;

  /// No description provided for @status_upcoming.
  ///
  /// In vi, this message translates to:
  /// **'Sắp tới'**
  String get status_upcoming;

  /// No description provided for @add_med_title.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thuốc mới'**
  String get add_med_title;

  /// No description provided for @input_med_name.
  ///
  /// In vi, this message translates to:
  /// **'Tên thuốc (VD: Paracetamol)'**
  String get input_med_name;

  /// No description provided for @input_dosage.
  ///
  /// In vi, this message translates to:
  /// **'Liều lượng (VD: 1 viên)'**
  String get input_dosage;

  /// No description provided for @input_time.
  ///
  /// In vi, this message translates to:
  /// **'Giờ uống'**
  String get input_time;

  /// No description provided for @btn_save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu lịch nhắc'**
  String get btn_save;

  /// No description provided for @btn_cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get btn_cancel;

  /// No description provided for @setting_language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ / Language'**
  String get setting_language;

  /// No description provided for @lang_vn.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get lang_vn;

  /// No description provided for @lang_en.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Anh'**
  String get lang_en;

  /// No description provided for @about_topic.
  ///
  /// In vi, this message translates to:
  /// **'Đề tài: Phần mềm Nhắc Thuốc'**
  String get about_topic;

  /// No description provided for @about_subject.
  ///
  /// In vi, this message translates to:
  /// **'Môn học: Lập trình TB Di động'**
  String get about_subject;

  /// No description provided for @about_instructor.
  ///
  /// In vi, this message translates to:
  /// **'GVHD: {name}'**
  String about_instructor(String name);

  /// No description provided for @about_team.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm phát triển'**
  String get about_team;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Pill Reminder';

  @override
  String get nav_home => 'Today';

  @override
  String get nav_medicines => 'Meds List';

  @override
  String get nav_settings => 'Settings';

  @override
  String get nav_about => 'About Us';

  @override
  String get hello_user => 'Hello there,';

  @override
  String today_summary(int count) {
    return 'You have $count meds today';
  }

  @override
  String get no_meds_today => 'No medications scheduled for today.';

  @override
  String get status_taken => 'Taken';

  @override
  String get status_skipped => 'Skipped';

  @override
  String get status_upcoming => 'Upcoming';

  @override
  String get add_med_title => 'Add New Medication';

  @override
  String get input_med_name => 'Medicine Name (e.g. Paracetamol)';

  @override
  String get input_dosage => 'Dosage (e.g. 1 pill)';

  @override
  String get input_time => 'Time to take';

  @override
  String get btn_save => 'Save Reminder';

  @override
  String get btn_cancel => 'Cancel';

  @override
  String get setting_language => 'Ngôn ngữ / Language';

  @override
  String get lang_vn => 'Tiếng Việt';

  @override
  String get lang_en => 'English';

  @override
  String get about_topic => 'Topic: Pill Reminder App';

  @override
  String get about_subject => 'Subject: Mobile App Development';

  @override
  String about_instructor(String name) {
    return 'Instructor: $name';
  }

  @override
  String get about_team => 'Development Team';
}

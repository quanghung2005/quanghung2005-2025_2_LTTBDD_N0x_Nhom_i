// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_title => 'Nhắc Thuốc';

  @override
  String get nav_home => 'Hôm nay';

  @override
  String get nav_medicines => 'Danh sách';

  @override
  String get nav_settings => 'Cài đặt';

  @override
  String get nav_about => 'Thông tin Nhóm';

  @override
  String get hello_user => 'Chào bạn,';

  @override
  String today_summary(int count) {
    return 'Bạn có $count liều thuốc hôm nay';
  }

  @override
  String get no_meds_today => 'Không có lịch uống thuốc nào.';

  @override
  String get status_taken => 'Đã uống';

  @override
  String get status_skipped => 'Bỏ qua';

  @override
  String get status_upcoming => 'Sắp tới';

  @override
  String get add_med_title => 'Thêm thuốc mới';

  @override
  String get input_med_name => 'Tên thuốc (VD: Paracetamol)';

  @override
  String get input_dosage => 'Liều lượng (VD: 1 viên)';

  @override
  String get input_time => 'Giờ uống';

  @override
  String get btn_save => 'Lưu lịch nhắc';

  @override
  String get btn_cancel => 'Hủy';

  @override
  String get setting_language => 'Ngôn ngữ / Language';

  @override
  String get lang_vn => 'Tiếng Việt';

  @override
  String get lang_en => 'Tiếng Anh';

  @override
  String get about_topic => 'Đề tài: Phần mềm Nhắc Thuốc';

  @override
  String get about_subject => 'Môn học: Lập trình TB Di động';

  @override
  String about_instructor(String name) {
    return 'GVHD: $name';
  }

  @override
  String get about_team => 'Nhóm phát triển';
}

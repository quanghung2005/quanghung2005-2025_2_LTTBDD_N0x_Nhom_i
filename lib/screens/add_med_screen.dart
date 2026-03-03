import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class AddMedScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  const AddMedScreen({super.key, this.initialData});

  @override
  State<AddMedScreen> createState() => _AddMedScreenState();
}

class _AddMedScreenState extends State<AddMedScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  String _selectedCategory = 'vitamin';
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _nameController.text = widget.initialData!['medicationName'] as String;
      _dosageController.text = widget.initialData!['dosage'] as String;
      _selectedCategory =
          widget.initialData!['category'] as String? ?? 'vitamin';

      final timeStr = widget.initialData!['time'] as String;
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        _selectedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? TimeOfDay.now().hour,
          minute: int.tryParse(parts[1]) ?? TimeOfDay.now().minute,
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialData != null
              ? (l10n?.edit_med_title ?? 'Cập nhật thông tin')
              : (l10n?.add_med_title ?? 'Thêm thuốc mới'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medication,
                    size: 50,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text(
                l10n?.input_med_name ?? 'Tên thuốc (VD: Paracetamol)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                l10n?.input_dosage ?? 'Liều lượng (VD: 1 viên)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _dosageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Phân loại thuốc / Category',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                dropdownColor: Colors.white,
                items: [
                  DropdownMenuItem(
                    value: 'vitamin',
                    child: Text(l10n?.filter_vitamin ?? 'Vitamin & Canxi'),
                  ),
                  DropdownMenuItem(
                    value: 'antibiotic',
                    child: Text(l10n?.filter_antibiotic ?? 'Kháng sinh'),
                  ),
                  DropdownMenuItem(
                    value: 'special',
                    child: Text(l10n?.filter_special ?? 'Thuốc đặc trị'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              Text(
                l10n?.input_time ?? 'Giờ uống',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedTime.format(context),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textColorDark,
                        ),
                      ),
                      const Icon(
                        Icons.access_time,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _dosageController.text.isNotEmpty) {
                    final timeString =
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';

                    IconData catIcon;
                    switch (_selectedCategory) {
                      case 'vitamin':
                        catIcon = Icons.healing;
                        break;
                      case 'antibiotic':
                        catIcon = Icons.medication;
                        break;
                      case 'special':
                        catIcon = Icons.local_hospital;
                        break;
                      default:
                        catIcon = Icons.medication_outlined;
                    }

                    Navigator.pop(context, {
                      'time': timeString,
                      'medicationName': _nameController.text,
                      'dosage': _dosageController.text,
                      'category': _selectedCategory,
                      'categoryIcon': catIcon,
                      'status': 'upcoming',
                    });
                  }
                },
                child: Text(
                  widget.initialData != null
                      ? (l10n?.btn_update ?? 'Cập nhật')
                      : (l10n?.btn_save ?? 'Lưu lịch nhắc'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  l10n?.btn_cancel ?? 'Hủy',
                  style: const TextStyle(
                    color: AppTheme.dangerColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

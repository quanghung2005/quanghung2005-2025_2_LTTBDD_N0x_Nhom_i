import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'add_med_screen.dart';
import 'about_screen.dart';
import 'settings_screen.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/medication_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _startMockNotificationTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startMockNotificationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkAndShowNotification();
    });
  }

  void _checkAndShowNotification() {
    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm');
    final currentTimeStr = timeFormat.format(now);

    for (int i = 0; i < _medications.length; i++) {
      final med = _medications[i];
      if (med['status'] == 'upcoming' &&
          med['time'] == currentTimeStr &&
          med['notified'] != true) {
        setState(() {
          _medications[i]['notified'] = true;
        });
        _showNotificationPopup(med, i);
      }
    }
  }

  void _showNotificationPopup(Map<String, dynamic> med, int index) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.notifications_active,
                color: Colors.redAccent,
                size: 28,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n?.notif_title ?? 'Đến giờ uống thuốc!',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${med['medicationName']}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text('${med['dosage']}', style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _medications[index]['status'] = 'skipped';
                });
                Navigator.pop(context);
              },
              child: Text(
                l10n?.notif_skip ?? 'Bỏ qua',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _medications[index]['status'] = 'taken';
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: Text(
                l10n?.notif_taken ?? 'Đã uống',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  final List<Map<String, dynamic>> _medications = [
    {
      'time': '08:00',
      'medicationName': 'Paracetamol',
      'dosage': '1 viên - Sau khi ăn',
      'category': 'special',
      'categoryIcon': Icons.medication_outlined,
      'status': 'taken',
    },
    {
      'time': '20:00',
      'medicationName': 'Vitamin C 500mg',
      'dosage': '1 viên - Trước khi ăn',
      'category': 'vitamin',
      'categoryIcon': Icons.healing,
      'status': 'upcoming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final filters = [
      {'key': 'all', 'label': l10n?.filter_all ?? 'Tất cả'},
      {'key': 'vitamin', 'label': l10n?.filter_vitamin ?? 'Vitamin & Canxi'},
      {'key': 'antibiotic', 'label': l10n?.filter_antibiotic ?? 'Kháng sinh'},
      {'key': 'special', 'label': l10n?.filter_special ?? 'Thuốc đặc trị'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.app_title ?? 'Nhắc Thuốc'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n?.nav_settings ?? 'Cài đặt',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: l10n?.nav_about ?? 'Thông tin',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.hello_user ?? 'Chào bạn,',
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n?.today_summary(_medications.length) ??
                        'Bạn có ${_medications.length} liều thuốc hôm nay',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                l10n?.nav_medicines ?? 'Danh sách',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final f = filters[index];
                  final isSelected = _selectedFilter == f['key'];
                  return ChoiceChip(
                    label: Text(f['label']!),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = f['key']!;
                      });
                    },
                    selectedColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.textColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: Colors.grey[200],
                    side: BorderSide.none,
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Builder(
                builder: (context) {
                  final filteredMeds = _selectedFilter == 'all'
                      ? _medications
                      : _medications
                            .where((m) => m['category'] == _selectedFilter)
                            .toList();

                  if (filteredMeds.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.event_note,
                            size: 60,
                            color: AppTheme.textColorLight,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n?.no_meds_today ??
                                'Không có lịch uống thuốc nào.',
                            style: const TextStyle(
                              color: AppTheme.textColorLight,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 80,
                      left: 16,
                      right: 16,
                    ),
                    itemCount: filteredMeds.length,
                    itemBuilder: (context, index) {
                      final med = filteredMeds[index];
                      final originalIndex = _medications.indexOf(med);

                      return TweenAnimationBuilder(
                        key: ValueKey(
                          med['medicationName'].toString() +
                              med['time'].toString(),
                        ),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(
                          milliseconds: 300 + (index * 100).clamp(0, 500),
                        ),
                        curve: Curves.easeOutQuart,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: MedicationCard(
                          time: med['time'] as String,
                          medicationName: med['medicationName'] as String,
                          dosage: med['dosage'] as String,
                          categoryIcon: med['categoryIcon'] as IconData,
                          status: med['status'] as String,
                          onStatusChanged: (newStatus) {
                            setState(() {
                              _medications[originalIndex]['status'] = newStatus;
                            });
                          },
                          onEdit: () async {
                            final updatedMed =
                                await Navigator.push<Map<String, dynamic>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddMedScreen(initialData: med),
                                  ),
                                );
                            if (updatedMed != null) {
                              setState(() {
                                _medications[originalIndex] = updatedMed;
                                _medications.sort(
                                  (a, b) => (a['time'] as String).compareTo(
                                    b['time'] as String,
                                  ),
                                );
                              });
                            }
                          },
                          onDelete: () {
                            setState(() {
                              _medications.removeAt(originalIndex);
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newMed = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (context) => const AddMedScreen()),
          );

          if (newMed != null) {
            setState(() {
              _medications.add(newMed);
              _medications.sort(
                (a, b) => (a['time'] as String).compareTo(b['time'] as String),
              );
            });
          }
        },
        icon: const Icon(Icons.add),
        label: Text(l10n?.add_med_title ?? 'Thêm thuốc'),
      ),
    );
  }
}

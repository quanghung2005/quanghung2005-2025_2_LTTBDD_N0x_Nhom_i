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
  final List<Map<String, dynamic>> _medications = [
    {
      'time': '08:00',
      'medicationName': 'Paracetamol',
      'dosage': '1 viên - Sau khi ăn',
      'categoryIcon': Icons.medication_outlined,
      'status': 'taken',
    },
    {
      'time': '20:00',
      'medicationName': 'Vitamin C 500mg',
      'dosage': '1 viên - Trước khi ăn',
      'categoryIcon': Icons.healing,
      'status': 'upcoming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                l10n?.nav_medicines ?? 'Lịch trình hôm nay',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorDark,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: _medications.isEmpty
                  ? Center(
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
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 80,
                        left: 16,
                        right: 16,
                      ),
                      itemCount: _medications.length,
                      itemBuilder: (context, index) {
                        final med = _medications[index];
                        return MedicationCard(
                          time: med['time'] as String,
                          medicationName: med['medicationName'] as String,
                          dosage: med['dosage'] as String,
                          categoryIcon: med['categoryIcon'] as IconData,
                          status: med['status'] as String,
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

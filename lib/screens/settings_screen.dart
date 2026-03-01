import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.nav_settings ?? 'Cài đặt')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.setting_language ?? 'Ngôn ngữ / Language',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColorLight,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withAlpha(50)),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: Text(l10n?.lang_vn ?? 'Tiếng Việt'),
                    value: 'vi',
                    groupValue: 'vi',
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {},
                  ),
                  const Divider(height: 1),
                  RadioListTile<String>(
                    title: Text(l10n?.lang_en ?? 'English'),
                    value: 'en',
                    groupValue: 'vi',
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

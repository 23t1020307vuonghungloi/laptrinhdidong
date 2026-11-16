// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLanguageSheet(BuildContext context) {
    final settings = AppSettings.instance;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  settings.t('choose_language'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RadioListTile<String>(
                  title: const Text('Tiếng Việt'),
                  value: 'vi',
                  groupValue: settings.languageCode,
                  onChanged: (val) {
                    if (val != null) settings.setLanguage(val);
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: settings.languageCode,
                  onChanged: (val) {
                    if (val != null) settings.setLanguage(val);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFontSizeSheet(BuildContext context) {
    final settings = AppSettings.instance;
    final options = [
      {'label': settings.t('size_small'), 'scale': 0.85},
      {'label': settings.t('size_medium'), 'scale': 1.0},
      {'label': settings.t('size_large'), 'scale': 1.2},
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  settings.t('choose_font_size'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...options.map((opt) {
                  final scale = opt['scale'] as double;
                  return RadioListTile<double>(
                    title: Text(opt['label'] as String),
                    value: scale,
                    groupValue: settings.textScaleFactor,
                    onChanged: (val) {
                      if (val != null) settings.setTextScale(val);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        const brandBlue = Color(0xFF1E3A8A);
        final borderColor =
            isDark ? Colors.grey.shade700 : Colors.grey.shade400;
        final subTextColor = theme.colorScheme.onSurfaceVariant;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              settings.t('settings'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: brandBlue,
            foregroundColor: Colors.white,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // NHÓM 1: TÀI KHOẢN
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  settings.t('account_section'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: subTextColor,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(settings.t('notifications')),
                      value: settings.notificationsEnabled,
                      activeColor: brandBlue,
                      onChanged: settings.toggleNotifications,
                    ),
                    Divider(height: 1, color: borderColor),
                    SwitchListTile(
                      title: Text(settings.t('dark_mode')),
                      value: settings.isDarkMode,
                      activeColor: brandBlue,
                      onChanged: settings.toggleDarkMode,
                    ),
                    Divider(height: 1, color: borderColor),
                    SwitchListTile(
                      title: Text(settings.t('remember_login')),
                      value: settings.rememberLogin,
                      activeColor: brandBlue,
                      onChanged: settings.toggleRememberLogin,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // NHÓM 2: ỨNG DỤNG
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  settings.t('app_section'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: subTextColor,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(settings.t('language')),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            settings.languageLabel,
                            style: TextStyle(color: subTextColor, fontSize: 13),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.chevron_right, color: subTextColor),
                        ],
                      ),
                      onTap: () => _showLanguageSheet(context),
                    ),
                    Divider(height: 1, color: borderColor),
                    ListTile(
                      title: Text(settings.t('font_size')),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            settings.fontSizeLabel,
                            style: TextStyle(color: subTextColor, fontSize: 13),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.chevron_right, color: subTextColor),
                        ],
                      ),
                      onTap: () => _showFontSizeSheet(context),
                    ),
                    Divider(height: 1, color: borderColor),
                    ListTile(
                      title: Text(settings.t('about_app')),
                      trailing: Icon(Icons.chevron_right, color: subTextColor),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(settings.t('about_app')),
                            content: Text(settings.t('about_desc')),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(settings.t('close')),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // NÚT PROFILE & ĐĂNG XUẤT
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: isDark ? theme.colorScheme.primary : brandBlue,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text(
                  settings.t('profile'),
                  style: TextStyle(
                    color: isDark ? theme.colorScheme.primary : brandBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: Text(
                  settings.t('logout'),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
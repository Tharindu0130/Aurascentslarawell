import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return ListView(
            children: [
              // Account Section
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Account'),
                subtitle: Text('Manage your account settings'),
              ),
              
              const Divider(),
              
              // Notifications
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Enable/disable notifications'),
                value: true,
                onChanged: (bool value) {},
              ),
              
              const Divider(),
              
              // Theme Mode Selection
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme Mode'),
                subtitle: Text(_getThemeModeText(appState.themeMode)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showThemeModeDialog(context, appState),
              ),
              
              const Divider(),
              
              // Language
              const ListTile(
                leading: Icon(Icons.language),
                title: Text('Language'),
                subtitle: Text('English'),
              ),
              
              const Divider(),
              
              // Privacy Policy
              const ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy'),
                subtitle: Text('View our privacy policy'),
              ),
              
              const Divider(),
              
              // Terms of Service
              const ListTile(
                leading: Icon(Icons.gavel),
                title: Text('Terms of Service'),
                subtitle: Text('View our terms of service'),
              ),
              
              const Divider(),
              
              // About
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                subtitle: Text('Learn about our app'),
              ),
              
              const Divider(),
              
              // Sensor Demo
              ListTile(
                leading: Icon(Icons.sensors, color: Theme.of(context).colorScheme.primary),
                title: const Text('Sensor Demo'),
                subtitle: const Text('Test accelerometer & gyroscope'),
                onTap: () {
                  Navigator.of(context).pushNamed('/sensors');
                },
              ),
              
              const Divider(),
              
              // Sign Out
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                onTap: () {
                  appState.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  void _showThemeModeDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('Light Mode'),
                value: ThemeMode.light,
                groupValue: appState.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    appState.setThemeMode(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark Mode'),
                value: ThemeMode.dark,
                groupValue: appState.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    appState.setThemeMode(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('System Default'),
                value: ThemeMode.system,
                groupValue: appState.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    appState.setThemeMode(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
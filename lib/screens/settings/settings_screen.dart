import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import '../../utils/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
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
              
              // Dark Mode (System-based)
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Use system theme'),
                value: false,
                onChanged: (bool value) {},
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
}
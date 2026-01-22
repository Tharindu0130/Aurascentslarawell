import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import '../../providers/app_state.dart';
import '../../providers/location_provider.dart';
import '../../providers/connectivity_provider.dart';
import '../../utils/theme.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final user = appState.user;
          
          if (user == null) {
            return const Center(
              child: Text('No user data available'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        backgroundImage: user.profileImageUrl != null
                            ? NetworkImage(user.profileImageUrl!)
                            : null,
                        child: user.profileImageUrl == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: AppTheme.primaryColor,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImageOptions(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // User Info
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Profile Details
                _buildProfileSection(
                  context,
                  'Personal Information',
                  [
                    _buildInfoTile(
                      Icons.phone,
                      'Phone',
                      user.phoneNumber ?? 'Not provided',
                    ),
                    _buildInfoTile(
                      Icons.location_on,
                      'Address',
                      user.address ?? 'Not provided',
                    ),
                    _buildInfoTile(
                      Icons.calendar_today,
                      'Member Since',
                      _formatDate(user.createdAt),
                    ),
                    if (user.lastLoginAt != null)
                      _buildInfoTile(
                        Icons.access_time,
                        'Last Login',
                        _formatDate(user.lastLoginAt!),
                      ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // App Settings
                _buildProfileSection(
                  context,
                  'App Settings',
                  [
                    _buildActionTile(
                      Icons.location_searching,
                      'Location Services',
                      'Manage location permissions',
                      () => _checkLocation(context),
                    ),
                    _buildActionTile(
                      Icons.wifi,
                      'Network Status',
                      'Check connectivity',
                      () => _showNetworkStatus(context),
                    ),
                    _buildActionTile(
                      Icons.camera,
                      'Camera Access',
                      'Test camera functionality',
                      () => _testCamera(context),
                    ),
                    _buildActionTile(
                      Icons.settings,
                      'Settings',
                      'App settings and preferences',
                      () => Navigator.pushNamed(context, '/settings'),
                    ),
                    _buildActionTile(
                      Icons.help,
                      'Help & Support',
                      'Get help and support',
                      () => Navigator.pushNamed(context, '/help'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _chooseFromGallery(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _takePhoto(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera functionality available (Demo)'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera error: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _chooseFromGallery(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery selection would be implemented here (Demo)'),
      ),
    );
  }

  void _checkLocation(BuildContext context) {
    final locationProvider = context.read<LocationProvider>();
    locationProvider.getCurrentLocation().then((_) {
      String message;
      if (locationProvider.currentPosition != null) {
        message = 'Location: ${locationProvider.currentPosition!.latitude.toStringAsFixed(4)}, ${locationProvider.currentPosition!.longitude.toStringAsFixed(4)}';
      } else {
        message = locationProvider.errorMessage ?? 'Location unavailable';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  void _showNetworkStatus(BuildContext context) {
    final connectivity = context.read<ConnectivityProvider>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Network Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${connectivity.isOnline ? 'Connected' : 'Disconnected'}'),
            Text('Type: ${connectivity.connectionType}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _testCamera(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Camera Status'),
          content: Text('Found ${cameras.length} camera(s)'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera error: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AppState>().logout();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
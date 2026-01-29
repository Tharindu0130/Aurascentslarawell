import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../providers/app_state.dart';
import '../../providers/location_provider.dart';
import '../../providers/connectivity_provider.dart';
import 'edit_profile_screen.dart';
import '../camera/camera_capture_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _capturedImagePath;

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
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        backgroundImage: _capturedImagePath != null
                            ? FileImage(File(_capturedImagePath!))
                            : (user.profileImageUrl != null
                                ? NetworkImage(user.profileImageUrl!)
                                : null) as ImageProvider?,
                        child: _capturedImagePath == null && user.profileImageUrl == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImagePickerOptions(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_a_photo,
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
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildInfoTile(
                      Icons.location_on,
                      'Address',
                      user.address ?? 'Not provided',
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildInfoTile(
                      Icons.calendar_today,
                      'Member Since',
                      _formatDate(user.createdAt),
                      Theme.of(context).colorScheme.primary,
                    ),
                    if (user.lastLoginAt != null)
                      _buildInfoTile(
                        Icons.access_time,
                        'Last Login',
                        _formatDate(user.lastLoginAt!),
                        Theme.of(context).colorScheme.primary,
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
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildActionTile(
                      Icons.wifi,
                      'Network Status',
                      'Check connectivity',
                      () => _showNetworkStatus(context),
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildActionTile(
                      Icons.camera,
                      'Update Profile Picture',
                      'Use camera or gallery to update your photo',
                      () => _showImagePickerOptions(context),
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildActionTile(
                      Icons.shopping_bag,
                      'My Orders',
                      'View your order history',
                      () => Navigator.pushNamed(context, '/orders'),
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildActionTile(
                      Icons.settings,
                      'Settings',
                      'App settings and preferences',
                      () => Navigator.pushNamed(context, '/settings'),
                      Theme.of(context).colorScheme.primary,
                    ),
                    _buildActionTile(
                      Icons.help,
                      'Help & Support',
                      'Get help and support',
                      () => Navigator.pushNamed(context, '/help'),
                      Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child:                   ElevatedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
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

  Widget _buildInfoTile(IconData icon, String title, String subtitle, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
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

  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap, Color iconColor) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
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

  /// Show bottom sheet with camera and gallery options
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Choose Profile Picture',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Camera Option
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: const Text('Take Photo'),
                  subtitle: const Text('Use camera to capture a new photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _openCamera(context);
                  },
                ),
                
                // Gallery Option
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  title: const Text('Choose from Gallery'),
                  subtitle: const Text('Select an existing photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery(context);
                  },
                ),
                
                const SizedBox(height: 10),
                
                // Cancel Button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Open camera to capture profile picture
  Future<void> _openCamera(BuildContext context) async {
    try {
      // Navigate to camera capture screen
      final imagePath = await Navigator.of(context).push<String>(
        MaterialPageRoute(
          builder: (context) => const CameraCaptureScreen(),
        ),
      );

      // Update profile picture if photo was captured
      if (imagePath != null && mounted) {
        setState(() {
          _capturedImagePath = imagePath;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Profile picture updated from camera!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Pick image from gallery
  Future<void> _pickImageFromGallery(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        setState(() {
          _capturedImagePath = image.path;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Profile picture updated from gallery!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gallery error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
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
              child: Text(
                'Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
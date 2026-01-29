import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../providers/auth_provider.dart';
import '../../providers/app_state.dart';
import '../../models/user.dart';
import '../camera/camera_capture_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String? _capturedImagePath;

  @override
  void initState() {
    super.initState();
    final user = context.read<AppState>().user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final appState = context.read<AppState>();
      final currentUser = appState.user;
      
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim().isEmpty 
              ? null 
              : _phoneController.text.trim(),
          address: _addressController.text.trim().isEmpty 
              ? null 
              : _addressController.text.trim(),
        );

        await appState.updateProfile(updatedUser);

        if (mounted) {
          if (appState.errorMessage == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appState.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Consumer<AppState>(
            builder: (context, appState, _) {
              return TextButton(
                onPressed: appState.isLoading ? null : _saveProfile,
                child: appState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    Consumer<AppState>(
                      builder: (context, appState, _) {
                        final user = appState.user;
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          backgroundImage: _capturedImagePath != null
                              ? FileImage(File(_capturedImagePath!))
                              : (user?.profileImageUrl != null
                                  ? NetworkImage(user!.profileImageUrl!)
                                  : null) as ImageProvider?,
                          child: _capturedImagePath == null && user?.profileImageUrl == null
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                        );
                      },
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
              
              const SizedBox(height: 40),
              
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Email Field (Read-only)
              Consumer<AppState>(
                builder: (context, appState, _) {
                  return TextFormField(
                    initialValue: appState.user?.email ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: Icon(Icons.lock_outlined),
                    ),
                    enabled: false,
                  );
                },
              ),
              
              const SizedBox(height: 20),
              
              // Phone Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (Optional)',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value.trim())) {
                      return 'Please enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Address Field
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address (Optional)',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (value.trim().length < 10) {
                      return 'Address must be at least 10 characters';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 40),
              
              // Additional Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Information',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Consumer<AppState>(
                        builder: (context, appState, _) {
                          final user = appState.user;
                          return Column(
                            children: [
                              _buildInfoRow(
                                'Member Since',
                                user?.createdAt != null
                                    ? '${user!.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}'
                                    : 'Unknown',
                              ),
                              if (user?.lastLoginAt != null)
                                _buildInfoRow(
                                  'Last Login',
                                  '${user!.lastLoginAt!.day}/${user.lastLoginAt!.month}/${user.lastLoginAt!.year}',
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
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
}
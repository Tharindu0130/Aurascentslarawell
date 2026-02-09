import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// Full camera capture screen with preview and photo capture
class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get available cameras
      _cameras = await availableCameras();
      
      if (_cameras.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras found on this device';
          _isLoading = false;
        });
        return;
      }

      // Use front camera for profile pictures (or back if front not available)
      final camera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize camera: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      // Show capturing feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('📸 Capturing...'),
          duration: Duration(milliseconds: 500),
        ),
      );

      // Capture the image
      final XFile image = await _controller!.takePicture();
      
      // Get app directory
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Copy to permanent location
      await File(image.path).copy(imagePath);
      
      // Return the path to previous screen
      if (mounted) {
        Navigator.of(context).pop(imagePath);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to capture photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;

    try {
      setState(() => _isLoading = true);

      final currentDirection = _controller?.description.lensDirection;
      final newCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection != currentDirection,
        orElse: () => _cameras.first,
      );

      await _controller?.dispose();

      _controller = CameraController(
        newCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to switch camera: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Take Profile Picture'),
        actions: [
          if (_cameras.length > 1)
            IconButton(
              icon: const Icon(Icons.flip_camera_android),
              onPressed: _switchCamera,
              tooltip: 'Switch Camera',
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _isInitialized
          ? FloatingActionButton.large(
              onPressed: _capturePhoto,
              backgroundColor: Colors.white,
              child: const Icon(Icons.camera, size: 32, color: Colors.black),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Initializing camera...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _initializeCamera,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isInitialized && _controller != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview
          CameraPreview(_controller!),
          
          // Guide overlay
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
          
          // Instruction text
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Colors.black.withOpacity(0.7),
              child: const Text(
                'Position your face in the circle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return const Center(
      child: Text(
        'Camera not available',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

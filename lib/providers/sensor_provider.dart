import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

/// Provider for managing device sensor data
/// Listens to accelerometer and gyroscope events
class SensorProvider with ChangeNotifier {
  // Accelerometer data
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  // Gyroscope data
  double _gyroscopeX = 0.0;
  double _gyroscopeY = 0.0;
  double _gyroscopeZ = 0.0;

  // Magnetometer data
  double _magnetometerX = 0.0;
  double _magnetometerY = 0.0;
  double _magnetometerZ = 0.0;

  // Stream subscriptions
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  // Error tracking
  String? _errorMessage;
  bool _isListening = false;

  // Getters - Accelerometer
  double get accelerometerX => _accelerometerX;
  double get accelerometerY => _accelerometerY;
  double get accelerometerZ => _accelerometerZ;

  // Getters - Gyroscope
  double get gyroscopeX => _gyroscopeX;
  double get gyroscopeY => _gyroscopeY;
  double get gyroscopeZ => _gyroscopeZ;

  // Getters - Magnetometer
  double get magnetometerX => _magnetometerX;
  double get magnetometerY => _magnetometerY;
  double get magnetometerZ => _magnetometerZ;

  // Status getters
  String? get errorMessage => _errorMessage;
  bool get isListening => _isListening;

  /// Start listening to sensor events
  void startListening() {
    if (_isListening) return;

    try {
      // Listen to accelerometer
      _accelerometerSubscription = accelerometerEventStream().listen(
        (AccelerometerEvent event) {
          _accelerometerX = event.x;
          _accelerometerY = event.y;
          _accelerometerZ = event.z;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Accelerometer error: $error';
          notifyListeners();
        },
      );

      // Listen to gyroscope
      _gyroscopeSubscription = gyroscopeEventStream().listen(
        (GyroscopeEvent event) {
          _gyroscopeX = event.x;
          _gyroscopeY = event.y;
          _gyroscopeZ = event.z;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Gyroscope error: $error';
          notifyListeners();
        },
      );

      // Listen to magnetometer
      _magnetometerSubscription = magnetometerEventStream().listen(
        (MagnetometerEvent event) {
          _magnetometerX = event.x;
          _magnetometerY = event.y;
          _magnetometerZ = event.z;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Magnetometer error: $error';
          notifyListeners();
        },
      );

      _isListening = true;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to start sensors: $e';
      notifyListeners();
    }
  }

  /// Stop listening to sensor events
  void stopListening() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    
    _accelerometerSubscription = null;
    _gyroscopeSubscription = null;
    _magnetometerSubscription = null;
    
    _isListening = false;
    notifyListeners();
  }

  /// Calculate total acceleration magnitude
  double get accelerationMagnitude {
    return (_accelerometerX * _accelerometerX +
            _accelerometerY * _accelerometerY +
            _accelerometerZ * _accelerometerZ)
        .abs()
        .toDouble();
  }

  /// Calculate total rotation magnitude
  double get rotationMagnitude {
    return (_gyroscopeX * _gyroscopeX +
            _gyroscopeY * _gyroscopeY +
            _gyroscopeZ * _gyroscopeZ)
        .abs()
        .toDouble();
  }

  /// Detect if device is being shaken
  bool get isShaking {
    return accelerationMagnitude > 150; // Threshold for shake detection
  }

  /// Detect device orientation (simplified)
  String get deviceOrientation {
    if (_accelerometerZ.abs() > 9) {
      return _accelerometerZ > 0 ? 'Face Up' : 'Face Down';
    } else if (_accelerometerX.abs() > 9) {
      return _accelerometerX > 0 ? 'Left Side Down' : 'Right Side Down';
    } else if (_accelerometerY.abs() > 9) {
      return _accelerometerY > 0 ? 'Top Down' : 'Bottom Down';
    }
    return 'Unknown';
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }
}

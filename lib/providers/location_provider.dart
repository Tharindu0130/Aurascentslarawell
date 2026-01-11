import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  bool _isLoading = false;
  String? _errorMessage;
  bool _serviceEnabled = false;
  LocationPermission _permission = LocationPermission.denied;

  Position? get currentPosition => _currentPosition;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasLocation => _currentPosition != null;

  Future<void> getCurrentLocation() async {
    _setLoading(true);
    _clearError();

    try {
      // Check if location services are enabled
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        _setError('Location services are disabled. Please enable location services.');
        _setLoading(false);
        return;
      }

      // Check location permissions
      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission == LocationPermission.denied) {
          _setError('Location permissions are denied');
          _setLoading(false);
          return;
        }
      }

      if (_permission == LocationPermission.deniedForever) {
        _setError('Location permissions are permanently denied, we cannot request permissions.');
        _setLoading(false);
        return;
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

    } catch (e) {
      _setError('Failed to get location: ${e.toString()}');
    }

    _setLoading(false);
  }

  Future<double> getDistanceToStore(double storeLat, double storeLng) async {
    if (_currentPosition == null) {
      await getCurrentLocation();
    }

    if (_currentPosition != null) {
      return Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        storeLat,
        storeLng,
      );
    }

    return 0.0;
  }

  String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
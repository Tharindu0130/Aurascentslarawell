import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityProvider with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isOnline = false;

  ConnectivityProvider() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  ConnectivityResult get connectionStatus => _connectionStatus;
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  String get connectionType {
    switch (_connectionStatus) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
      default:
        return 'No Connection';
    }
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }

    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    _isOnline = result != ConnectivityResult.none;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
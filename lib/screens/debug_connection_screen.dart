import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DebugConnectionScreen extends StatefulWidget {
  const DebugConnectionScreen({super.key});

  @override
  State<DebugConnectionScreen> createState() => _DebugConnectionScreenState();
}

class _DebugConnectionScreenState extends State<DebugConnectionScreen> {
  final ApiService _apiService = ApiService();
  bool _isChecking = false;
  String _status = 'Not checked yet';
  Color _statusColor = Colors.grey;
  Map<String, dynamic> _details = {};

  Future<void> _checkConnection() async {
    setState(() {
      _isChecking = true;
      _status = 'Checking...';
      _statusColor = Colors.orange;
      _details = {};
    });

    try {
      // Check backend ping
      final pingResult = await _apiService.pingBackend();
      
      if (pingResult) {
        // Backend is reachable, try to get products
        final productsResponse = await _apiService.getProducts(limit: 5);
        
        if (productsResponse['success'] == true) {
          final productCount = (productsResponse['data'] as List).length;
          setState(() {
            _status = '✅ Connected Successfully!';
            _statusColor = Colors.green;
            _details = {
              'Backend': 'Reachable ✓',
              'API Status': 'Working ✓',
              'Products Found': '$productCount products',
              'Base URL': ApiService.baseUrl,
            };
          });
        } else {
          setState(() {
            _status = '⚠️ Connected but no products';
            _statusColor = Colors.orange;
            _details = {
              'Backend': 'Reachable ✓',
              'API Status': 'Error: ${productsResponse['message']}',
              'Base URL': ApiService.baseUrl,
            };
          });
        }
      } else {
        setState(() {
          _status = '❌ Cannot connect to backend';
          _statusColor = Colors.red;
          _details = {
            'Backend': 'Not reachable ✗',
            'Base URL': ApiService.baseUrl,
            'Problem': 'Backend server is not running or URL is wrong',
          };
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Connection Error';
        _statusColor = Colors.red;
        _details = {
          'Error': e.toString(),
          'Base URL': ApiService.baseUrl,
        };
      });
    }

    setState(() {
      _isChecking = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Diagnostics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: _statusColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (_isChecking)
                      const CircularProgressIndicator()
                    else
                      Icon(
                        _statusColor == Colors.green
                            ? Icons.check_circle
                            : _statusColor == Colors.red
                                ? Icons.error
                                : Icons.info,
                        size: 60,
                        color: _statusColor,
                      ),
                    const SizedBox(height: 16),
                    Text(
                      _status,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _statusColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Details
            if (_details.isNotEmpty) ...[
              const Text(
                'Details:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._details.entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        '${entry.key}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.toString(),
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
            
            const SizedBox(height: 30),
            
            // Action buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isChecking ? null : _checkConnection,
                icon: const Icon(Icons.refresh),
                label: const Text('Check Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        'How to Fix',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '1. Start your Laravel backend:\n'
                    '   php artisan serve --host=0.0.0.0 --port=8000\n\n'
                    '2. Check the Base URL in api_service.dart:\n'
                    '   • Android Emulator: http://10.0.2.2:8000/api\n'
                    '   • Real device: http://YOUR_IP:8000/api\n\n'
                    '3. Make sure you have products in your database\n\n'
                    '4. After fixing, click "Check Again" button',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

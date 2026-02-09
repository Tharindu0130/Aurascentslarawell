import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sensor_provider.dart';

class SensorDemoScreen extends StatefulWidget {
  const SensorDemoScreen({super.key});

  @override
  State<SensorDemoScreen> createState() => _SensorDemoScreenState();
}

class _SensorDemoScreenState extends State<SensorDemoScreen> {
  @override
  void initState() {
    super.initState();
    // Start listening to sensors when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SensorProvider>().startListening();
    });
  }

  @override
  void dispose() {
    // Stop listening when screen closes to save battery
    context.read<SensorProvider>().stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
        actions: [
          Consumer<SensorProvider>(
            builder: (context, sensorProvider, _) {
              return IconButton(
                icon: Icon(
                  sensorProvider.isListening ? Icons.sensors : Icons.sensors_off,
                ),
                onPressed: () {
                  if (sensorProvider.isListening) {
                    sensorProvider.stopListening();
                  } else {
                    sensorProvider.startListening();
                  }
                },
                tooltip: sensorProvider.isListening ? 'Stop Sensors' : 'Start Sensors',
              );
            },
          ),
        ],
      ),
      body: Consumer<SensorProvider>(
        builder: (context, sensorProvider, _) {
          if (!sensorProvider.isListening) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sensors_off,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Sensors are stopped',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => sensorProvider.startListening(),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Listening'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          sensorProvider.isShaking
                              ? Icons.vibration
                              : Icons.sensors,
                          size: 48,
                          color: sensorProvider.isShaking
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sensorProvider.isShaking
                              ? 'Device is Shaking!'
                              : 'Sensors Active',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: sensorProvider.isShaking
                                ? Theme.of(context).colorScheme.error
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Orientation: ${sensorProvider.deviceOrientation}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),

                // Accelerometer Card
                _buildSensorCard(
                  context,
                  'Accelerometer',
                  'Measures acceleration forces',
                  Icons.speed,
                  [
                    _buildSensorValue('X', sensorProvider.accelerometerX, 'm/s²'),
                    _buildSensorValue('Y', sensorProvider.accelerometerY, 'm/s²'),
                    _buildSensorValue('Z', sensorProvider.accelerometerZ, 'm/s²'),
                  ],
                  sensorProvider.accelerationMagnitude,
                  'm/s²',
                ),

                const SizedBox(height: 16),

                // Gyroscope Card
                _buildSensorCard(
                  context,
                  'Gyroscope',
                  'Measures rotation rate',
                  Icons.threed_rotation,
                  [
                    _buildSensorValue('X', sensorProvider.gyroscopeX, 'rad/s'),
                    _buildSensorValue('Y', sensorProvider.gyroscopeY, 'rad/s'),
                    _buildSensorValue('Z', sensorProvider.gyroscopeZ, 'rad/s'),
                  ],
                  sensorProvider.rotationMagnitude,
                  'rad/s',
                ),

                const SizedBox(height: 16),

                // Magnetometer Card
                _buildSensorCard(
                  context,
                  'Magnetometer',
                  'Measures magnetic field',
                  Icons.explore,
                  [
                    _buildSensorValue('X', sensorProvider.magnetometerX, 'µT'),
                    _buildSensorValue('Y', sensorProvider.magnetometerY, 'µT'),
                    _buildSensorValue('Z', sensorProvider.magnetometerZ, 'µT'),
                  ],
                  null,
                  null,
                ),

                if (sensorProvider.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              sensorProvider.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSensorCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    List<Widget> values,
    double? magnitude,
    String? unit,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...values,
            if (magnitude != null && unit != null) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Magnitude:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${magnitude.toStringAsFixed(2)} $unit',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSensorValue(String axis, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$axis Axis:',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            '${value.toStringAsFixed(3)} $unit',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

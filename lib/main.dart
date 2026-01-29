import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/app_state.dart';
import 'providers/perfume_provider.dart';
import 'providers/location_provider.dart';
import 'providers/connectivity_provider.dart';
import 'providers/sensor_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/perfume/perfume_detail_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';

import 'screens/settings/settings_screen.dart';
import 'screens/help/help_screen.dart';
import 'screens/sensors/sensor_demo_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'utils/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(PerfumeStoreApp(prefs: prefs));
}

class PerfumeStoreApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const PerfumeStoreApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Central App State Provider (manages auth, cart, wishlist)
        ChangeNotifierProvider(create: (_) => AppState(prefs)),
        
        // Feature-specific providers
        ChangeNotifierProvider(create: (_) => PerfumeProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => SensorProvider()),
        // Note: Cart provider is now part of AppState provider

      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'Aura Scents',
            themeMode: appState.themeMode,
            theme: MaterialTheme(TextTheme()).light(),
            darkTheme: MaterialTheme(TextTheme()).dark(),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/cart': (context) => const CartScreen(),
              '/wishlist': (context) => const WishlistScreen(),
              '/orders': (context) => const OrdersScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/help': (context) => const HelpScreen(),
              '/sensors': (context) => const SensorDemoScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/perfume-detail') {
                final perfume = settings.arguments;
                return MaterialPageRoute(
                  builder: (context) => PerfumeDetailScreen(perfume: perfume),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
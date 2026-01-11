import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/perfume_provider.dart';
import 'providers/location_provider.dart';
import 'providers/connectivity_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/perfume/perfume_detail_screen.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider(prefs)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PerfumeProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Perfume Store',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/cart': (context) => const CartScreen(),
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
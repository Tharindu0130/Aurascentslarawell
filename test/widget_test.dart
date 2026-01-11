import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:perfume_store/main.dart';

void main() {
  testWidgets('Perfume Store app smoke test', (WidgetTester tester) async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(PerfumeStoreApp(prefs: prefs));

    // Verify that the splash screen is displayed
    expect(find.text('Perfume Store'), findsOneWidget);
    expect(find.text('Discover Your Signature Scent'), findsOneWidget);
  });

  testWidgets('Navigation to login screen', (WidgetTester tester) async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(PerfumeStoreApp(prefs: prefs));

    // Wait for splash screen animation and navigation
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Should navigate to login screen since no user is logged in
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
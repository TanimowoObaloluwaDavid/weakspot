import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:weakspot_client/weakspot_client.dart';

import 'screens/home_screen.dart';

/// Global client used to talk to the Serverpod backend. Generated from the
/// server code, so endpoint calls are type-checked.
late final Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final url = await getServerUrl();
  client = Client(url)..connectivityMonitor = FlutterConnectivityMonitor();

  runApp(const WeakSpotApp());
}

/// Shared palette. Defined once here so the colour meaning stays consistent:
/// red always means "this topic is dragging you down".
class AppColors {
  AppColors._();

  static const brand = Color(0xFF4F46E5);
  static const weak = Color(0xFFDC2626);
  static const weakSoft = Color(0xFFFEE2E2);
  static const mid = Color(0xFFD97706);
  static const midSoft = Color(0xFFFEF3C7);
  static const strong = Color(0xFF059669);
  static const strongSoft = Color(0xFFD1FAE5);
  static const ink = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const hairline = Color(0xFFE5E7EB);
}

ThemeData _theme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.brand,
    brightness: brightness,
  );

  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: brightness == Brightness.light
        ? const Color(0xFFF8FAFC)
        : scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.ink,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.hairline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.brand, width: 2),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

class WeakSpotApp extends StatelessWidget {
  const WeakSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeakSpot',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}

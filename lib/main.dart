import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

/// Root aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi OOP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

/// Konstanta warna global aplikasi
class AppColors {
  AppColors._(); // Mencegah instansiasi
  static const Color primary = Color(0xFFB71C1C);
  static const Color secondary = Color(0xFFE53935);
}

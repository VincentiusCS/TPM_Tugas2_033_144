import 'package:flutter/material.dart';
import '../main.dart';
import '../models/menu_item.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'data_kelompok_page.dart';
import 'arithmetic_page.dart';
import 'bilangan_page.dart';
import 'jumlah_total_page.dart';
import 'stopwatch_page.dart';
import 'pyramid_page.dart';
import 'weton_hari_page.dart';
import 'usia_page.dart';
import 'year_converter_page.dart';

/// Halaman utama dengan grid menu
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Membuat daftar menu (Factory Method pattern)
  List<MenuItem> _buildMenuItems() => [
    MenuItem(
      title: 'Data Kelompok',
      icon: Icons.group,
      color: Colors.blue,
      page: const DataKelompokPage(),
    ),
    MenuItem(
      title: 'Penjumlahan & Pengurangan',
      icon: Icons.calculate,
      color: Colors.green,
      page: const ArithmeticPage(),
    ),
    MenuItem(
      title: 'Ganjil/Genap & Bilangan Prima',
      icon: Icons.numbers,
      color: Colors.orange,
      page: const BilanganPage(),
    ),
    MenuItem(
      title: 'Jumlah Total Angka',
      icon: Icons.calculate,
      color: Colors.purple,
      page: const JumlahTotalPage(),
    ),
    MenuItem(
      title: 'Stopwatch',
      icon: Icons.timer,
      color: Colors.teal,
      page: const StopwatchPage(),
    ),
    MenuItem(
      title: 'Luas & Volume Piramid',
      icon: Icons.change_history,
      color: AppColors.primary,
      page: const PyramidPage(),
    ),
    MenuItem(
      title: 'Cek Hari & Weton',
      icon: Icons.calendar_today,
      color: Colors.lightBlue,
      page: const WetonHariPage(),
    ),
    MenuItem(
      title: 'Cek Usia',
      icon: Icons.cake,
      color: Colors.pink,
      page: const UsiaPage(),
    ),
    MenuItem(
      title: 'Konversi Tahun',
      icon: Icons.date_range,
      color: Colors.indigo,
      page: const YearConverterPage(),
    ),
  ];

  void _handleLogout(BuildContext context) {
    AuthService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menus = _buildMenuItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Utama',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Keluar',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: menus.length,
          itemBuilder: (context, i) => MenuCard(item: menus[i]),
        ),
      ),
    );
  }
}

/// Widget kartu menu — dipisah sebagai class tersendiri
class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: item.color.withOpacity(0.15),
              radius: 30,
              child: Icon(item.icon, color: item.color, size: 32),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

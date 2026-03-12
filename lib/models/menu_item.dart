import 'package:flutter/material.dart';

/// Model untuk item menu di halaman utama
class MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });
}

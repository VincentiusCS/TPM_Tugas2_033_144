import 'package:flutter/material.dart';
import '../main.dart';

/// Utility class berisi widget reusable untuk seluruh aplikasi
/// Constructor private mencegah instansiasi — semua method bersifat static
class AppWidgets {
  AppWidgets._();

  /// AppBar standar dengan warna primary
  static AppBar buildAppBar(String title) => AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      );

  /// Input field standar dengan opsional multiline dan tipe keyboard
  static Widget buildInputField(
    String label,
    TextEditingController ctrl, {
    bool isInt = false,
    int maxLines = 1,
  }) =>
      TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: isInt
            ? TextInputType.number
            : maxLines > 1
                ? TextInputType.multiline
                : const TextInputType.numberWithOptions(decimal: true, signed: true),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      );

  /// Tombol aksi lebar penuh
  static Widget buildActionButton(
    String label,
    Color color,
    VoidCallback onTap,
  ) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      );

  /// Card hijau untuk menampilkan hasil perhitungan
  static Widget buildResultCard(String text) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.7),
          textAlign: TextAlign.center,
        ),
      );

  /// Card merah untuk menampilkan pesan error
  static Widget buildErrorCard(String text) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.red))),
          ],
        ),
      );

  /// Card section dengan header ikon dan judul berwarna
  static Widget buildSectionCard(
    String title,
    IconData icon,
    Color color,
    Widget child,
  ) =>
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              child,
            ],
          ),
        ),
      );
}

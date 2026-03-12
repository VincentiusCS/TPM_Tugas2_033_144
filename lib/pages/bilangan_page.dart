import 'package:flutter/material.dart';
import '../models/hasil_hitung.dart';
import '../services/calculator_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Cek Ganjil/Genap dan Bilangan Prima
class BilanganPage extends StatefulWidget {
  const BilanganPage({super.key});

  @override
  State<BilanganPage> createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _ctrl = TextEditingController();

  HasilBilangan? _hasil;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _cek() {
    setState(() {
      _error = null;
      _hasil = null;
    });

    final n = int.tryParse(_ctrl.text.trim());
    if (n == null) {
      setState(() => _error = 'Masukkan bilangan bulat yang valid!');
      return;
    }

    // Menggunakan BilanganCalculator (extends BaseCalculator)
    final calculator = BilanganCalculator(angka: n);
    setState(() => _hasil = calculator.hitung());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Ganjil/Genap & Bilangan Prima'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppWidgets.buildInputField(
              'Masukkan Bilangan Bulat', _ctrl, isInt: true),
            const SizedBox(height: 24),
            AppWidgets.buildActionButton('Cek Bilangan', Colors.orange, _cek),
            const SizedBox(height: 20),
            if (_error != null) AppWidgets.buildErrorCard(_error!),
            if (_hasil != null) HasilBilanganCard(hasil: _hasil!),
          ],
        ),
      ),
    );
  }
}

/// Widget kartu hasil cek bilangan (dipisah sebagai class tersendiri)
class HasilBilanganCard extends StatelessWidget {
  final HasilBilangan hasil;

  const HasilBilanganCard({super.key, required this.hasil});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Text(
            '${hasil.angka}',
            style: const TextStyle(
                fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BadgeChip(
                label: hasil.statusGanjilGenap,
                color: hasil.isGenap ? Colors.blue : Colors.purple,
              ),
              BadgeChip(
                label: hasil.isPrima ? 'Prima ✓' : 'Bukan Prima ✗',
                color: hasil.isPrima ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget chip badge berwarna
class BadgeChip extends StatelessWidget {
  final String label;
  final Color color;

  const BadgeChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }
}

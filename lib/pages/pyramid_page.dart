import 'package:flutter/material.dart';
import '../main.dart';
import '../models/hasil_hitung.dart';
import '../services/calculator_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Luas & Volume Piramid
class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final TextEditingController _alasCtrl = TextEditingController();
  final TextEditingController _tinggiCtrl = TextEditingController();

  HasilPiramid? _hasil;
  String? _error;

  @override
  void dispose() {
    _alasCtrl.dispose();
    _tinggiCtrl.dispose();
    super.dispose();
  }

  void _hitung() {
    setState(() {
      _error = null;
      _hasil = null;
    });

    final s = double.tryParse(_alasCtrl.text.trim());
    final t = double.tryParse(_tinggiCtrl.text.trim());

    if (s == null || t == null || s <= 0 || t <= 0) {
      setState(() => _error = 'Masukkan nilai positif yang valid!');
      return;
    }

    // Menggunakan PiramidCalculator (extends BaseCalculator)
    final calculator = PiramidCalculator(sisiAlas: s, tinggi: t);
    setState(() => _hasil = calculator.hitung());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Luas & Volume Piramid'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppWidgets.buildSectionCard(
              'Piramid Alas Persegi',
              Icons.change_history,
              AppColors.primary,
              Column(
                children: [
                  AppWidgets.buildInputField('Panjang Sisi Alas (s)', _alasCtrl),
                  const SizedBox(height: 16),
                  AppWidgets.buildInputField('Tinggi Piramid (t)', _tinggiCtrl),
                  const SizedBox(height: 20),
                  AppWidgets.buildActionButton(
                      'Hitung', AppColors.primary, _hitung),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null) AppWidgets.buildErrorCard(_error!),
            if (_hasil != null) HasilPiramidCard(hasil: _hasil!),
          ],
        ),
      ),
    );
  }
}

/// Widget kartu hasil hitung piramid dengan tampilan detail
class HasilPiramidCard extends StatelessWidget {
  final HasilPiramid hasil;

  const HasilPiramidCard({super.key, required this.hasil});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.change_history, size: 52, color: Colors.red),
          ),
          const SizedBox(height: 16),
          PiramidRow(label: 'Sisi Alas (s)', value: hasil.sisiAlas.toStringAsFixed(2)),
          PiramidRow(label: 'Tinggi (t)', value: hasil.tinggi.toStringAsFixed(2)),
          const Divider(height: 20),
          PiramidRow(label: 'Luas Alas', value: hasil.luasAlas.toStringAsFixed(4)),
          PiramidRow(label: 'Apotema Sisi', value: hasil.apotema.toStringAsFixed(4)),
          PiramidRow(label: 'Luas Permukaan', value: hasil.luasPermukaan.toStringAsFixed(4)),
          const Divider(height: 20),
          PiramidRow(
            label: 'Volume Piramid',
            value: hasil.volume.toStringAsFixed(4),
            bold: true,
          ),
        ],
      ),
    );
  }
}

/// Widget baris label-nilai untuk hasil piramid
class PiramidRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const PiramidRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: bold ? Colors.red : Colors.black87,
              fontSize: bold ? 15 : 13,
            ),
          ),
        ],
      ),
    );
  }
}

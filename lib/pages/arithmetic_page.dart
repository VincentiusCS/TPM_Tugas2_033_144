import 'package:flutter/material.dart';
import '../models/hasil_hitung.dart';
import '../services/calculator_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Penjumlahan dan Pengurangan
/// Menggunakan AritmetikaCalculator (extends BaseCalculator)
class ArithmeticPage extends StatefulWidget {
  const ArithmeticPage({super.key});

  @override
  State<ArithmeticPage> createState() => _ArithmeticPageState();
}

class _ArithmeticPageState extends State<ArithmeticPage> {
  final TextEditingController _angka1Ctrl = TextEditingController();
  final TextEditingController _angka2Ctrl = TextEditingController();

  HasilAritmetika? _hasil;
  String? _error;

  @override
  void dispose() {
    _angka1Ctrl.dispose();
    _angka2Ctrl.dispose();
    super.dispose();
  }

  void _hitung(String operator_) {
    setState(() {
      _error = null;
      _hasil = null;
    });

    final a = double.tryParse(_angka1Ctrl.text.trim());
    final b = double.tryParse(_angka2Ctrl.text.trim());

    if (a == null || b == null) {
      setState(() => _error = 'Masukkan angka yang valid!');
      return;
    }

    // Polymorphism: memanggil hitung() dari subclass AritmetikaCalculator
    final calculator = AritmetikaCalculator(
      angka1: a,
      angka2: b,
      operator_: operator_,
    );

    setState(() => _hasil = calculator.hitung());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Penjumlahan & Pengurangan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppWidgets.buildInputField('Angka Pertama', _angka1Ctrl),
            const SizedBox(height: 16),
            AppWidgets.buildInputField('Angka Kedua', _angka2Ctrl),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppWidgets.buildActionButton(
                    'Jumlahkan (+)', Colors.green, () => _hitung('+')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppWidgets.buildActionButton(
                    'Kurangkan (−)', Colors.orange, () => _hitung('-')),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_error != null) AppWidgets.buildErrorCard(_error!),
            if (_hasil != null) AppWidgets.buildResultCard(_hasil!.toString()),
          ],
        ),
      ),
    );
  }
}

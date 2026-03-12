import 'package:flutter/material.dart';
import '../models/hasil_hitung.dart';
import '../services/calculator_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Jumlah Total Angka
class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final TextEditingController _ctrl = TextEditingController();

  HasilJumlahTotal? _hasil;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _hitung() {
    setState(() {
      _error = null;
      _hasil = null;
    });

    // Static method untuk parsing (OOP utility)
    final angka = JumlahTotalCalculator.parseInput(_ctrl.text);

    if (angka.isEmpty) {
      setState(() => _error = 'Tidak ada angka valid yang ditemukan!');
      return;
    }

    final calculator = JumlahTotalCalculator(angka: angka);
    setState(() => _hasil = calculator.hitung());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Jumlah Total Angka'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan angka-angka (pisahkan dengan spasi atau koma):',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            AppWidgets.buildInputField(
              'Contoh: 10 20 30 40', _ctrl, maxLines: 4),
            const SizedBox(height: 16),
            AppWidgets.buildActionButton('Hitung Total', Colors.purple, _hitung),
            const SizedBox(height: 20),
            if (_error != null) AppWidgets.buildErrorCard(_error!),
            if (_hasil != null) AppWidgets.buildResultCard(_hasil!.toString()),
          ],
        ),
      ),
    );
  }
}

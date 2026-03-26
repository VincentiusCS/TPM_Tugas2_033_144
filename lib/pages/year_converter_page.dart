import 'package:flutter/material.dart';
import '../models/calendar_models.dart';
import '../services/calendar_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Konversi Tahun Masehi ke Hijriah dan Saka
class YearConverterPage extends StatefulWidget {
  const YearConverterPage({super.key});

  @override
  State<YearConverterPage> createState() => _YearConverterPageState();
}

class _YearConverterPageState extends State<YearConverterPage> {
  final TextEditingController _ctrlTanggal = TextEditingController();
  final TextEditingController _ctrlBulan = TextEditingController();
  final TextEditingController _ctrlTahun = TextEditingController();

  HasilKonversiTahun? _hasil;
  String? _error;

  @override
  void dispose() {
    _ctrlTanggal.dispose();
    _ctrlBulan.dispose();
    _ctrlTahun.dispose();
    super.dispose();
  }

  void _konversi() {
    setState(() {
      _error = null;
      _hasil = null;
    });

    final tanggal = int.tryParse(_ctrlTanggal.text.trim());
    final bulan = int.tryParse(_ctrlBulan.text.trim());
    final tahun = int.tryParse(_ctrlTahun.text.trim());

    if (tanggal == null || bulan == null || tahun == null) {
      setState(() => _error = 'Masukkan tanggal, bulan, dan tahun yang valid!');
      return;
    }

    if (tanggal < 1 || tanggal > 31) {
      setState(() => _error = 'Tanggal harus antara 1-31!');
      return;
    }

    if (bulan < 1 || bulan > 12) {
      setState(() => _error = 'Bulan harus antara 1-12!');
      return;
    }

    if (tahun < 1) {
      setState(() => _error = 'Tahun harus positif!');
      return;
    }

    try {
      final hasil = CalendarService.konversiTahun(tanggal, bulan, tahun);

      setState(() {
        _hasil = HasilKonversiTahun(
          hari: hasil['hari'],
          bulan: hasil['bulan'],
          tahunMasehi: hasil['tahun_masehi'],
          tahunHijriah: hasil['tahun_hijriah'],
          tahunSaka: hasil['tahun_saka'],
        );
      });
    } catch (e) {
      setState(() => _error = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Konversi Tahun'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Konversi tanggal Masehi ke Hijriah dan Saka',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppWidgets.buildInputField(
                    'Tanggal (DD)',
                    _ctrlTanggal,
                    isInt: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppWidgets.buildInputField(
                    'Bulan (MM)',
                    _ctrlBulan,
                    isInt: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppWidgets.buildInputField(
                    'Tahun (YYYY)',
                    _ctrlTahun,
                    isInt: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppWidgets.buildActionButton(
              'Konversi Tahun',
              Colors.teal,
              _konversi,
            ),
            const SizedBox(height: 20),
            if (_error != null) AppWidgets.buildErrorCard(_error!),
            if (_hasil != null) _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final hasil = _hasil!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Tanggal: ${hasil.hari}/${hasil.bulan}/${hasil.tahunMasehi}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 32),
          _buildConverterRow(
            label: 'Tahun Masehi',
            value: hasil.tahunMasehi.toString(),
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 16),
          _buildConverterRow(
            label: 'Tahun Hijriah',
            value: hasil.tahunHijriah.toString(),
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 16),
          _buildConverterRow(
            label: 'Tahun Saka',
            value: hasil.tahunSaka.toString(),
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildConverterRow({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

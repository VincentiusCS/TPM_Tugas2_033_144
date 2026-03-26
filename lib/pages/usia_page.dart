import 'package:flutter/material.dart';
import '../models/calendar_models.dart';
import '../services/calendar_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Cek Usia
class UsiaPage extends StatefulWidget {
  const UsiaPage({super.key});

  @override
  State<UsiaPage> createState() => _UsiaPageState();
}

class _UsiaPageState extends State<UsiaPage> {
  final TextEditingController _ctrlTanggal = TextEditingController();
  final TextEditingController _ctrlBulan = TextEditingController();
  final TextEditingController _ctrlTahun = TextEditingController();

  HasilUsia? _hasil;
  String? _error;

  @override
  void dispose() {
    _ctrlTanggal.dispose();
    _ctrlBulan.dispose();
    _ctrlTahun.dispose();
    super.dispose();
  }

  void _hitung() {
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
      final usia = CalendarService.hitungUsia(tanggal, bulan, tahun);

      setState(() {
        _hasil = HasilUsia(
          menit: usia['menit']!,
          jam: usia['jam']!,
          hari: usia['hari']!,
          bulan: usia['bulan']!,
          tahun: usia['tahun']!,
          tanggalLahir: tanggal,
          bulanLahir: bulan,
          tahunLahir: tahun,
        );
      });
    } catch (e) {
      setState(() => _error = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Cek Usia'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Masukkan tanggal lahir Anda (DD, MM, YYYY)',
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
            AppWidgets.buildActionButton('Hitung Usia', Colors.purple, _hitung),
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Tanggal Lahir: ${hasil.tanggalLahir}/${hasil.bulanLahir}/${hasil.tahunLahir}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildAgeItem('Tahun', hasil.tahun.toString(), Colors.red),
              _buildAgeItem('Bulan', hasil.bulan.toString(), Colors.orange),
              _buildAgeItem('Hari', hasil.hari.toString(), Colors.green),
              _buildAgeItem('Jam', hasil.jam.toString(), Colors.blue),
              _buildAgeItem('Menit', hasil.menit.toString(), Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
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

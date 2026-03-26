import 'package:flutter/material.dart';
import '../models/calendar_models.dart';
import '../services/calendar_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Cek Hari dan Weton
class WetonHariPage extends StatefulWidget {
  const WetonHariPage({super.key});

  @override
  State<WetonHariPage> createState() => _WetonHariPageState();
}

class _WetonHariPageState extends State<WetonHariPage> {
  final TextEditingController _ctrlTanggal = TextEditingController();
  final TextEditingController _ctrlBulan = TextEditingController();
  final TextEditingController _ctrlTahun = TextEditingController();

  HasilWetonHari? _hasil;
  String? _error;

  @override
  void dispose() {
    _ctrlTanggal.dispose();
    _ctrlBulan.dispose();
    _ctrlTahun.dispose();
    super.dispose();
  }

  void _cek() {
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
      final hari = CalendarService.getHari(tanggal, bulan, tahun);
      final weton = CalendarService.getWeton(tanggal, bulan, tahun);

      setState(() {
        _hasil = HasilWetonHari(
          hari: hari,
          weton: weton,
          tanggal: tanggal,
          bulan: bulan,
          tahun: tahun,
        );
      });
    } catch (e) {
      setState(() => _error = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Cek Hari & Weton'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Masukkan tanggal dalam format DD, MM, YYYY',
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
            AppWidgets.buildActionButton('Cek Hari & Weton', Colors.blue, _cek),
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Text(
            '${hasil.tanggal}/${hasil.bulan}/${hasil.tahun}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Hari',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hasil.hari,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Weton',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hasil.weton,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

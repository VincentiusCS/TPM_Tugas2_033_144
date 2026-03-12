import 'package:flutter/material.dart';
import '../models/kelompok.dart';
import '../services/kelompok_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Data Kelompok
class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data melalui service (Dependency Injection)
    final KelompokService service = KelompokService();
    final Kelompok kelompok = service.getKelompok();

    return Scaffold(
      appBar: AppWidgets.buildAppBar('Data Kelompok'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppWidgets.buildSectionCard(
              kelompok.namaKelompok,
              Icons.group,
              Colors.blue,
              Column(
                children: kelompok.anggota
                    .map((a) => AnggotaTile(anggota: a))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total Anggota: ${kelompok.jumlahAnggota} orang',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget tile satu anggota (dipisah sebagai class tersendiri)
class AnggotaTile extends StatelessWidget {
  final Anggota anggota;

  const AnggotaTile({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(
          anggota.nama[0],
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        anggota.nama,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('NIM: ${anggota.nim} • ${anggota.prodi}'),
    );
  }
}

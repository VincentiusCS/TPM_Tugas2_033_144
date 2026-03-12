import '../models/kelompok.dart';

/// Service untuk menyediakan data kelompok (Singleton)
class KelompokService {
  static final KelompokService _instance = KelompokService._internal();
  factory KelompokService() => _instance;
  KelompokService._internal();

  /// Mengembalikan data kelompok (simulasi sumber data / repository)
  Kelompok getKelompok() {
    return const Kelompok(
      namaKelompok: 'Teknologi Pemrograman Mobile IF D – Teknik Informatika',
      anggota: [
        Anggota(nama: 'Wahyu Febriansyah', nim: '123220033', prodi: 'Teknik Informatika'),
        Anggota(nama: 'Vincentius Christian Sugianto', nim: '123220144', prodi: 'Teknik Informatika'),
      ],
    );
  }
}

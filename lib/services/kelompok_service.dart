import '../models/kelompok.dart';

/// Service untuk menyediakan data kelompok (Singleton)
class KelompokService {
  static final KelompokService _instance = KelompokService._internal();
  factory KelompokService() => _instance;
  KelompokService._internal();

  /// Mengembalikan data kelompok (simulasi sumber data / repository)
  Kelompok getKelompok() {
    return const Kelompok(
      namaKelompok: 'Kelompok 1 – Teknik Informatika',
      anggota: [
        Anggota(nama: 'Andi Pratama', nim: '2301001', prodi: 'Teknik Informatika'),
        Anggota(nama: 'Budi Santoso', nim: '2301002', prodi: 'Teknik Informatika'),
        Anggota(nama: 'Citra Dewi',   nim: '2301003', prodi: 'Teknik Informatika'),
        Anggota(nama: 'Dian Rahayu',  nim: '2301004', prodi: 'Teknik Informatika'),
      ],
    );
  }
}

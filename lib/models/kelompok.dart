/// Model Anggota - merepresentasikan satu anggota kelompok
class Anggota {
  final String nama;
  final String nim;
  final String prodi;

  const Anggota({
    required this.nama,
    required this.nim,
    required this.prodi,
  });

  @override
  String toString() => 'Anggota(nama: $nama, nim: $nim, prodi: $prodi)';
}

/// Model Kelompok - mengelola daftar anggota
/// Menerapkan Encapsulation: _anggotaList bersifat private
class Kelompok {
  final String namaKelompok;
  final List<Anggota> _anggotaList;

  const Kelompok({
    required this.namaKelompok,
    required List<Anggota> anggota,
  }) : _anggotaList = anggota;

  /// Mengembalikan salinan list (tidak bisa dimodifikasi dari luar)
  List<Anggota> get anggota => List.unmodifiable(_anggotaList);

  int get jumlahAnggota => _anggotaList.length;
}

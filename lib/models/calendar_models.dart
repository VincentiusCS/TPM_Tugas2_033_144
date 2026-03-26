/// Model untuk hasil pemeriksaan hari dan weton
class HasilWetonHari {
  final String hari;
  final String weton;
  final int tanggal;
  final int bulan;
  final int tahun;

  HasilWetonHari({
    required this.hari,
    required this.weton,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
  });
}

/// Model untuk hasil perhitungan usia
class HasilUsia {
  final int menit;
  final int jam;
  final int hari;
  final int bulan;
  final int tahun;
  final int tanggalLahir;
  final int bulanLahir;
  final int tahunLahir;

  HasilUsia({
    required this.menit,
    required this.jam,
    required this.hari,
    required this.bulan,
    required this.tahun,
    required this.tanggalLahir,
    required this.bulanLahir,
    required this.tahunLahir,
  });
}

/// Model untuk hasil konversi tahun
class HasilKonversiTahun {
  final int hari;
  final int bulan;
  final int tahunMasehi;
  final int tahunHijriah;
  final int tahunSaka;

  HasilKonversiTahun({
    required this.hari,
    required this.bulan,
    required this.tahunMasehi,
    required this.tahunHijriah,
    required this.tahunSaka,
  });
}

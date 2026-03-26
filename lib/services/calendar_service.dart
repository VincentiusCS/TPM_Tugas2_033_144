/// Service untuk kalkulasi tanggal, hari, weton, usia, dan konversi tahun
class CalendarService {
  // Daftar hari dalam Bahasa Indonesia
  static const List<String> daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  // Daftar weton Jawa (5 hari berulang)
  static const List<String> daftarWeton = [
    'Legi',
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
  ];

  /// Mendapatkan hari dari tanggal (menggunakan algoritma Zeller)
  static String getHari(int hari, int bulan, int tahun) {
    // Algoritma Zeller untuk mencari hari dalam minggu
    // Hasil: 0=Minggu, 1=Senin, ..., 6=Sabtu
    if (bulan < 3) {
      bulan += 12;
      tahun--;
    }
    int k = tahun % 100;
    int j = tahun ~/ 100;
    int h = (hari + (13 * (bulan + 1)) ~/ 5 + k + k ~/ 4 + j ~/ 4 - 2 * j) % 7;
    // Konversi hasil Zeller ke indeks 0-6 (Senin-Minggu)
    int dayIndex = (h + 5) % 7;
    return daftarHari[dayIndex];
  }

  /// Mendapatkan weton dari tanggal menggunakan Julian Day Number
  static String getWeton(int hari, int bulan, int tahun) {
    // Hitung Julian Day Number untuk akurasi historis
    int a = (14 - bulan) ~/ 12;
    int y = tahun + 4800 - a;
    int m = bulan + 12 * a - 3;

    int jdn = hari + (153 * m + 2) ~/ 5 + 365 * y + y ~/ 4 - y ~/ 100 + y ~/ 400 - 32045;

    // Weton adalah JDN mod 5
    int wetonIndex = jdn % 5;

    return daftarWeton[wetonIndex];
  }

  /// Menghitung usia dalam berbagai unit
  /// Returns: {tahun, bulan, hari, jam, menit} - sisa setiap unitnya
  static Map<String, int> hitungUsia(
    int hariLahir,
    int bulanLahir,
    int tahunLahir,
  ) {
    DateTime sekarang = DateTime.now();
    DateTime lahir = DateTime(tahunLahir, bulanLahir, hariLahir);

    // Hitung total durasi
    Duration durasi = sekarang.difference(lahir);

    int totalMenit = durasi.inMinutes;
    int totalJam = durasi.inHours;
    int totalHari = durasi.inDays;

    // Hitung tahun (365 hari per tahun)
    int tahunHitung = totalHari ~/ 365;
    int sisaHariSetelahTahun = totalHari % 365;

    // Hitung bulan dari sisa hari (30 hari per bulan)
    int bulanHitung = sisaHariSetelahTahun ~/ 30;
    int sisaHariSetelahBulan = sisaHariSetelahTahun % 30;

    // Hari adalah sisa setelah bulan
    int hariHitung = sisaHariSetelahBulan;

    // Hitung jam dari sisa jam (24 jam per hari)
    int jamHitung = totalJam % 24;

    // Hitung menit dari sisa menit (60 menit per jam)
    int menitHitung = totalMenit % 60;

    return {
      'tahun': tahunHitung,
      'bulan': bulanHitung,
      'hari': hariHitung,
      'jam': jamHitung,
      'menit': menitHitung,
    };
  }

  /// Konversi tahun Masehi ke Hijriah
  static int konversiKeHijriah(int tahunMasehi) {
    // Formula: Hijriah = ((Masehi - 622) * 33) / 32
    int tahunHijriah = ((tahunMasehi - 622) * 33) ~/ 32;
    return tahunHijriah;
  }

  /// Konversi tahun Masehi ke Saka
  static int konversiKeSaka(int tahunMasehi) {
    // Tahun Saka dimulai pada 78 Masehi = 0 Saka
    int tahunSaka = tahunMasehi - 78;
    return tahunSaka;
  }

  /// Konversi lengkap tanggal Masehi ke Hijriah dan Saka
  static Map<String, dynamic> konversiTahun(
    int hari,
    int bulan,
    int tahunMasehi,
  ) {
    int tahunHijriah = konversiKeHijriah(tahunMasehi);
    int tahunSaka = konversiKeSaka(tahunMasehi);

    return {
      'hari': hari,
      'bulan': bulan,
      'tahun_masehi': tahunMasehi,
      'tahun_hijriah': tahunHijriah,
      'tahun_saka': tahunSaka,
    };
  }
}

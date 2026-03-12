/// Model hasil perhitungan aritmetika
class HasilAritmetika {
  final double angka1;
  final double angka2;
  final String operator_;
  final double hasil;

  const HasilAritmetika({
    required this.angka1,
    required this.angka2,
    required this.operator_,
    required this.hasil,
  });

  String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);

  @override
  String toString() =>
      '${_fmt(angka1)} $operator_ ${_fmt(angka2)} = ${_fmt(hasil)}';
}

/// Model hasil cek bilangan ganjil/genap dan prima
class HasilBilangan {
  final int angka;
  final bool isGenap;
  final bool isPrima;

  const HasilBilangan({
    required this.angka,
    required this.isGenap,
    required this.isPrima,
  });

  String get statusGanjilGenap => isGenap ? 'Genap' : 'Ganjil';
  String get statusPrima =>
      isPrima ? 'Bilangan Prima ✓' : 'Bukan Bilangan Prima ✗';
}

/// Model hasil jumlah total angka
class HasilJumlahTotal {
  final List<double> angka;
  final double total;
  final double rataRata;

  const HasilJumlahTotal({
    required this.angka,
    required this.total,
    required this.rataRata,
  });

  int get jumlahAngka => angka.length;

  String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);

  @override
  String toString() =>
      'Jumlah angka : $jumlahAngka\n'
      'Total        : ${_fmt(total)}\n'
      'Rata-rata    : ${rataRata.toStringAsFixed(2)}';
}

/// Model hasil hitung luas & volume piramid
class HasilPiramid {
  final double sisiAlas;
  final double tinggi;
  final double luasAlas;
  final double apotema;
  final double luasPermukaan;
  final double volume;

  const HasilPiramid({
    required this.sisiAlas,
    required this.tinggi,
    required this.luasAlas,
    required this.apotema,
    required this.luasPermukaan,
    required this.volume,
  });
}

import 'dart:math';
import '../models/hasil_hitung.dart';

// ══════════════════════════════════════════════════════════
// ABSTRACTION — Abstract class sebagai kontrak kalkulator
// ══════════════════════════════════════════════════════════

/// Base abstract class: semua kalkulator WAJIB implement hitung()
abstract class BaseCalculator<T> {
  /// Method abstrak yang harus di-override oleh subclass
  T hitung();

  /// Method utilitas bersama (shared behavior via inheritance)
  String formatAngka(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);
}

// ══════════════════════════════════════════════════════════
// INHERITANCE — Subclass mewarisi BaseCalculator
// ══════════════════════════════════════════════════════════

/// Kalkulator penjumlahan dan pengurangan
class AritmetikaCalculator extends BaseCalculator<HasilAritmetika> {
  final double angka1;
  final double angka2;
  final String operator_;

  AritmetikaCalculator({
    required this.angka1,
    required this.angka2,
    required this.operator_,
  });

  @override
  HasilAritmetika hitung() {
    final hasil = operator_ == '+' ? angka1 + angka2 : angka1 - angka2;
    return HasilAritmetika(
      angka1: angka1,
      angka2: angka2,
      operator_: operator_,
      hasil: hasil,
    );
  }
}

/// Kalkulator cek ganjil/genap dan bilangan prima
class BilanganCalculator extends BaseCalculator<HasilBilangan> {
  final int angka;

  BilanganCalculator({required this.angka});

  @override
  HasilBilangan hitung() {
    return HasilBilangan(
      angka: angka,
      isGenap: _cekGenap(),
      isPrima: _cekPrima(),
    );
  }

  bool _cekGenap() => angka % 2 == 0;

  bool _cekPrima() {
    if (angka < 2) return false;
    for (int i = 2; i <= sqrt(angka.toDouble()); i++) {
      if (angka % i == 0) return false;
    }
    return true;
  }
}

/// Kalkulator jumlah total dari sekumpulan angka
class JumlahTotalCalculator extends BaseCalculator<HasilJumlahTotal> {
  final List<double> angka;

  JumlahTotalCalculator({required this.angka});

  @override
  HasilJumlahTotal hitung() {
    final total = angka.reduce((a, b) => a + b);
    return HasilJumlahTotal(
      angka: angka,
      total: total,
      rataRata: total / angka.length,
    );
  }

  /// Static factory method untuk parsing input string
  static List<double> parseInput(String input) {
    return input
        .trim()
        .split(RegExp(r'[\s,]+'))
        .map((s) => double.tryParse(s))
        .whereType<double>()
        .toList();
  }
}

/// Kalkulator luas permukaan dan volume piramid alas persegi
class PiramidCalculator extends BaseCalculator<HasilPiramid> {
  final double sisiAlas;
  final double tinggi;

  PiramidCalculator({required this.sisiAlas, required this.tinggi});

  @override
  HasilPiramid hitung() {
    final luasAlas = sisiAlas * sisiAlas;
    final apotema = sqrt((sisiAlas / 2) * (sisiAlas / 2) + tinggi * tinggi);
    final luasPermukaan = luasAlas + (4 * 0.5 * sisiAlas * apotema);
    final volume = (1 / 3) * luasAlas * tinggi;

    return HasilPiramid(
      sisiAlas: sisiAlas,
      tinggi: tinggi,
      luasAlas: luasAlas,
      apotema: apotema,
      luasPermukaan: luasPermukaan,
      volume: volume,
    );
  }
}

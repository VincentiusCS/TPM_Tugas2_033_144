import 'dart:async';

/// Service stopwatch - mengelola seluruh logika timer
/// Menerapkan Encapsulation: state internal tersembunyi dari luar
class StopwatchService {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  final List<String> _laps = [];

  /// Callback dipanggil setiap tick agar UI bisa rebuild
  final void Function() onTick;

  StopwatchService({required this.onTick});

  // ── Getters (baca-saja dari luar) ──────────────
  int get milliseconds => _milliseconds;
  bool get isRunning => _isRunning;
  List<String> get laps => List.unmodifiable(_laps);
  String get formattedTime => _format(_milliseconds);
  // ───────────────────────────────────────────────

  String _format(int ms) {
    final m = (ms ~/ 60000).toString().padLeft(2, '0');
    final s = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    final c = ((ms % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$m:$s.$c';
  }

  void start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      _milliseconds += 10;
      onTick();
    });
    _isRunning = true;
    onTick();
  }

  void pause() {
    _timer?.cancel();
    _isRunning = false;
    onTick();
  }

  void reset() {
    _timer?.cancel();
    _milliseconds = 0;
    _isRunning = false;
    _laps.clear();
    onTick();
  }

  void recordLap() {
    if (!_isRunning) return;
    _laps.insert(0, 'Lap ${_laps.length + 1}: ${_format(_milliseconds)}');
    onTick();
  }

  void dispose() => _timer?.cancel();
}

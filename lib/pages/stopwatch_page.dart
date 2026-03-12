import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import '../services/stopwatch_service.dart';
import '../widgets/app_widgets.dart';

/// Halaman Stopwatch
/// Logic sepenuhnya dikelola oleh StopwatchService (Separation of Concerns)
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late final StopwatchService _service;

  @override
  void initState() {
    super.initState();
    _service = StopwatchService(onTick: () => setState(() {}));
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.buildAppBar('Stopwatch'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            StopwatchDisplay(time: _service.formattedTime),
            const SizedBox(height: 32),
            StopwatchControls(service: _service),
            const SizedBox(height: 24),
            if (_service.laps.isNotEmpty)
              Expanded(child: LapList(laps: _service.laps)),
          ],
        ),
      ),
    );
  }
}

/// Widget tampilan waktu stopwatch
class StopwatchDisplay extends StatelessWidget {
  final String time;

  const StopwatchDisplay({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.teal, width: 6),
        color: Colors.teal.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFeatures: [FontFeature.tabularFigures()],
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}

/// Widget tombol kontrol stopwatch
class StopwatchControls extends StatelessWidget {
  final StopwatchService service;

  const StopwatchControls({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(icon: Icons.refresh, color: Colors.red, onTap: service.reset),
        const SizedBox(width: 20),
        CircleButton(
          icon: service.isRunning ? Icons.pause : Icons.play_arrow,
          color: service.isRunning ? Colors.orange : Colors.green,
          onTap: service.isRunning ? service.pause : service.start,
          size: 64,
        ),
        const SizedBox(width: 20),
        CircleButton(
          icon: Icons.flag,
          color: Colors.blue,
          onTap: service.isRunning ? service.recordLap : null,
        ),
      ],
    );
  }
}

/// Widget tombol bulat yang dapat dikonfigurasi
class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final double size;

  const CircleButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: onTap == null ? Colors.grey.shade300 : color,
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}

/// Widget daftar catatan lap
class LapList extends StatelessWidget {
  final List<String> laps;

  const LapList({super.key, required this.laps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const Text(
          'Catatan Lap',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: laps.length,
            itemBuilder: (_, i) => ListTile(
              dense: true,
              leading:
                  const Icon(Icons.flag_outlined, color: Colors.blue, size: 18),
              title: Text(laps[i]),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Times extends StatelessWidget {
  const Times({super.key, required this.inferenceTime, required this.fpsRate});

  final double? inferenceTime;
  final double? fpsRate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black54,
          ),
          child: Text(
            '${(inferenceTime ?? 0).toStringAsFixed(2)} ms\n${(fpsRate ?? 0).toStringAsFixed(2)} FPS',
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

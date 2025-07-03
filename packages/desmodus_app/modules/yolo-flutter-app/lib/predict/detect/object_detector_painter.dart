import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/predict/detect/detected_object.dart';

/// A painter used to draw the detected objects on the screen.
class ObjectDetectorPainter extends CustomPainter {
  /// Creates a [ObjectDetectorPainter].
  ObjectDetectorPainter(
    this._detectionResults, [
    this._colors,
    this._strokeWidth = 2.5,
  ]);

  final List<DetectedObject> _detectionResults;
  final List<Color>? _colors;
  final double _strokeWidth;

  // Store the time when the object was drawn (added for fade effect)
  final Map<DetectedObject, DateTime> _drawTimes = {};

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final colors = _colors ?? Colors.primaries;

    for (final detectedObject in _detectionResults) {
      final left = detectedObject.boundingBox.left;
      final top = detectedObject.boundingBox.top;
      final right = detectedObject.boundingBox.right;
      final bottom = detectedObject.boundingBox.bottom;
      final width = detectedObject.boundingBox.width;
      final height = detectedObject.boundingBox.height;

      if (left.isNaN ||
          top.isNaN ||
          right.isNaN ||
          bottom.isNaN ||
          width.isNaN ||
          height.isNaN) {
        return;
      }

      // Get the time when the object was drawn, or set it to the current time
      if (!_drawTimes.containsKey(detectedObject)) {
        _drawTimes[detectedObject] = DateTime.now();
      }

      final timeElapsed =
          DateTime.now().difference(_drawTimes[detectedObject]!).inMilliseconds;

      // Calculate opacity (from 1.0 to 0.0 over 3 seconds)
      double opacity = 1.0 - (timeElapsed / 3000);
      opacity = opacity.clamp(0.0, 1.0); // Ensure opacity doesn't go below 0

      // Draw the rectangle with fading effect
      final index = detectedObject.index % colors.length;
      final color = colors[index];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, height),
          const Radius.circular(8),
        ),
        borderPaint..color = color.withValues(alpha: opacity),
      );

      // Label
      final builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          textDirection: TextDirection.ltr,
        ),
      )
        ..pushStyle(
          ui.TextStyle(
            color: Colors.white.withValues(alpha: opacity), // Fading text color
            background: Paint()..color = color.withValues(alpha: opacity),
          ),
        )
        ..addText(' ${detectedObject.label} '
            '${(detectedObject.confidence * 100).toStringAsFixed(1)}\n')
        ..pop();
      canvas.drawParagraph(
        builder.build()..layout(ui.ParagraphConstraints(width: right - left)),
        Offset(max(0, left), max(0, top)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

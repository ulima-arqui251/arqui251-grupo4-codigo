import 'package:flutter/foundation.dart';
import 'package:ultralytics_yolo/ultralytics_yolo_platform_interface.dart';

enum LensDirection {
  front,
  back,
}

/// The state of the camera
class UltralyticsYoloCameraValue {
  /// Constructor to create an instance of [UltralyticsYoloCameraValue]
  UltralyticsYoloCameraValue({
    required this.isInferenceOn,
    required this.lensDirection,
    required this.strokeWidth,
    required this.deferredProcessing,
    required this.isFlashlightOn,
  });

  /// State of interpreter inference
  final bool isInferenceOn;

  /// The direction of the camera lens
  final int lensDirection;

  /// The direction of the camera lens
  final bool isFlashlightOn;

  /// The width of the stroke used to draw the bounding boxes
  final double strokeWidth;

  /// Whether the processing of the frames should be deferred (android only)
  final bool deferredProcessing;

  /// Creates a copy of this [UltralyticsYoloCameraValue] but with
  /// the given fields
  UltralyticsYoloCameraValue copyWith({
    bool? isInferenceOn,
    int? lensDirection,
    bool? isFlashlightOn,
    double? strokeWidth,
    bool? deferredProcessing,
  }) =>
      UltralyticsYoloCameraValue(
        isInferenceOn: isInferenceOn ?? this.isInferenceOn,
        isFlashlightOn: isFlashlightOn ?? this.isFlashlightOn,
        lensDirection: lensDirection ?? this.lensDirection,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        deferredProcessing: deferredProcessing ?? this.deferredProcessing,
      );
}

/// ValueNotifier that holds the state of the camera
class UltralyticsYoloCameraController
    extends ValueNotifier<UltralyticsYoloCameraValue> {
  /// Constructor to create an instance of [UltralyticsYoloCameraController]
  UltralyticsYoloCameraController({bool deferredProcessing = false})
      : super(
          UltralyticsYoloCameraValue(
            isInferenceOn: true,
            lensDirection: 1,
            isFlashlightOn: false,
            strokeWidth: 2.5,
            deferredProcessing: deferredProcessing,
          ),
        );

  final _ultralyticsYoloPlatform = UltralyticsYoloPlatform.instance;

  /// Toggles the direction of the camera lens
  Future<void> toggleLensDirection() async {
    final newLensDirection = value.lensDirection == LensDirection.back.index
        ? LensDirection.front.index
        : LensDirection.back.index;
    value = value.copyWith(lensDirection: newLensDirection);
    await _ultralyticsYoloPlatform.setLensDirection(newLensDirection);
  }

  /// Toggles the device flashlight
  Future<void> toggleFlashlight() async {
    final flashlightValue = value.isFlashlightOn ? false : true;
    value = value.copyWith(isFlashlightOn: flashlightValue);
    await _ultralyticsYoloPlatform.setFlashlightValue(flashlightValue);
  }

  /// Sets the width of the stroke used to draw the bounding boxes
  void setStrokeWidth(double strokeWidth) {
    value = value.copyWith(strokeWidth: strokeWidth);
  }

  /// Takes camera picture
  Future<String?> takePicture() async {
    return await _ultralyticsYoloPlatform.takePicture();
  }

  /// Closes the camera
  Future<void> closeCamera() async {
    await _ultralyticsYoloPlatform.closeCamera();
  }

  /// Starts the camera
  Future<void> startCamera() async {
    await _ultralyticsYoloPlatform.startCamera();
  }

  /// Stops the camera
  Future<void> toggleLivePrediction() async {
    if (value.isInferenceOn) {
      value = value.copyWith(isInferenceOn: false);
      await _ultralyticsYoloPlatform.pauseLivePrediction(value.lensDirection);
    } else {
      value = value.copyWith(isInferenceOn: true);
      await _ultralyticsYoloPlatform.resumeLivePrediction(value.lensDirection);
    }
  }
}

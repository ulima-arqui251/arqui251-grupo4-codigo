import 'package:get/get.dart';
import 'package:ultralytics_yolo/predict/detect/object_detector.dart';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:ultralytics_yolo/yolo_model.dart';

class DetectorController extends GetxController {
  final detectionModel = 'desmodus-yolo11'.obs;
  final detectionThreshold = 0.70.obs;

  final isInferenceOn = true.obs;
  final isFlashlightOn = false.obs;

  final localModelsInstalled = <String>[].obs;
  final inferencedCombo = 0.obs;

  Future<ObjectDetector> initObjectDetectorWithLocalModel() async {
    final selectedModel = detectionModel.value;

    final modelPath = await _copy("assets/models/$selectedModel/model.tflite");
    final metadataPath = await _copy(
      "assets/models/$selectedModel/metadata.yaml",
    );

    final model = LocalYoloModel(
      id: '',
      task: Task.detect,
      format: Format.tflite,
      modelPath: modelPath,
      metadataPath: metadataPath,
    );

    return ObjectDetector(model: model);
  }

  Future<String> _copy(String assetPath) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';

    await io.Directory(dirname(path)).create(recursive: true);

    final file = io.File(path);

    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }

    return file.path;
  }
}

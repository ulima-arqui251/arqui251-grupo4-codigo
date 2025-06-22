import 'package:desmodus_app/viewmodel/detector_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectorController>(() => DetectorController());
  }
}

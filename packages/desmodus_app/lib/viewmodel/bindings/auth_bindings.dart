import 'package:get/get.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}

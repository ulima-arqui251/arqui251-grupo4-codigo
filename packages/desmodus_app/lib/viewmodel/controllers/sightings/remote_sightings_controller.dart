import 'package:get/get.dart';
import 'package:desmodus_app/model/service/remote/avist_service.dart'
    show RemoteSightingsService;

import '../../../model/entity/avistamiento.dart';

class RemoteSightingsController extends GetxController {
  final service = RemoteSightingsService();

  final allAvistamientos = <Avist>[].obs;
  final myAvistamientos = <Avist>[].obs;
  final isLoading = true.obs;

  @override
  void onReady() async {
    await cargarAvistamientos();
    await cargarMisAvistamientos();
  }

  Future<void> cargarAvistamientos() async {
    try {
      isLoading.value = true;
      allAvistamientos.value = await service.getAllAvistamientos();
    } catch (e) {
      print('Error cargando avistamientos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cargarMisAvistamientos() async {
    try {
      isLoading.value = true;
      myAvistamientos.value = await service.getMyAvistamientos();
    } catch (e) {
      print('Error cargando mis avistamientos: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

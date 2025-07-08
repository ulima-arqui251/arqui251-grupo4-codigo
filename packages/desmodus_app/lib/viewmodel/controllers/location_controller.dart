import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    show openAppSettings;

class LocationController extends GetxController {
  final mapController = MapController();
  final mapKey = UniqueKey();
  final locacionGPS = Location();

  final isLoading = true.obs;
  final hasPermission = false.obs;

  final latitud = 0.0.obs;
  final longitud = 0.0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    try {
      await checkPermisoDeUbicacion();

      await _escucharEventosLocator();
    } catch (e) {
      print("Algo salió mal al inicializar el controlador de ubicación: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkPermisoDeUbicacion() async {
    try {
      final status = await locacionGPS.hasPermission();

      if (status == PermissionStatus.denied) {
        final newStatus = await locacionGPS.requestPermission();
        if (newStatus != PermissionStatus.granted) {
          await _mostrarDialogoPermiso(
            "Permisos de ubicación",
            "Para usar esta función, debes habilitar los permisos de ubicación.",
          );

          await locacionGPS.requestPermission();
        }
      } else if (status == PermissionStatus.deniedForever) {
        await _mostrarDialogoPermiso(
          "Permisos de ubicación",
          "Los permisos de ubicación están permanentemente denegados. Ve a la configuración para habilitarlos.",
          mostrarBotonConfiguracion: true,
        );
      }

      hasPermission.value =
          await locacionGPS.hasPermission() == PermissionStatus.granted;
    } catch (e) {
      // handle errors
    }
  }

  Future<void> _escucharEventosLocator() async {
    bool serviceEnabled = await locacionGPS.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await locacionGPS.requestService();
      if (!serviceEnabled) return;
    }

    final locationData = await locacionGPS.getLocation();
    latitud.value = locationData.latitude!;
    longitud.value = locationData.longitude!;

    locacionGPS.onLocationChanged.listen((LocationData locationData) {
      latitud.value = locationData.latitude!;
      longitud.value = locationData.longitude!;
    });
  }

  Future<void> abrirMapa() async {
    Get.toNamed(
      "/heatmap",
      arguments: {"latitud": latitud.value, "longitud": longitud.value},
    );
  }

  Future<void> _mostrarDialogoPermiso(
    String titulo,
    String contenido, {
    bool mostrarBotonConfiguracion = false,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: [
          if (mostrarBotonConfiguracion)
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancelar"),
            ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              openAppSettings();
            },
            child: const Text("Ir a configuración"),
          ),
        ],
      ),
    );
  }
}

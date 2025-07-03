import 'package:desmodus_app/utils/padding_extensions.dart';
import 'package:desmodus_app/utils/permissions.dart'
    show checkCameraAndStoragePermissions;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionsMissingWidget extends StatelessWidget {
  const PermissionsMissingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Faltan activar permisos!",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          20.pv,
          Text("Por favor, activa los permisos de cámara y almacenamiento."),
          20.pv,
          ElevatedButton(
            onPressed: () async {
              final permissionsGranted =
                  await checkCameraAndStoragePermissions();
              if (permissionsGranted) {
                Get.offNamed("/detector");
              }
            },
            child: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }
}

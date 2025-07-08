import 'package:desmodus_app/utils/padding_extensions.dart';
import 'package:desmodus_app/view/screens/heatmap/widgets/avistamiento_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:desmodus_app/view/screens/heatmap/widgets/avistamiento_tile.dart';
import 'package:desmodus_app/viewmodel/controllers/location_controller.dart';
import 'package:desmodus_app/viewmodel/controllers/sightings/remote_sightings_controller.dart';

class HeatmapScreen extends StatelessWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final avistController = Get.find<RemoteSightingsController>();

    void showAvistamientosRecientes() {
      Get.bottomSheet(
        DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.3,
          maxChildSize: 0.75,
          builder:
              (_, controller) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Listado de avistamientos',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      10.pv,
                      SizedBox(
                        height: 500,
                        // child: Obx(
                        //   () =>
                        //       (avistController.isLoading.value)
                        //           ? const Center(
                        //             child: CircularProgressIndicator(),
                        //           )
                        //           : ListView.separated(
                        //             separatorBuilder: (context, index) => 16.pv,
                        //             itemCount:
                        //                 avistController.allAvistamientos.length,
                        //             itemBuilder: (context, index) {
                        //               return AvistamientoTile(
                        //                 avistamiento:
                        //                     avistController
                        //                         .allAvistamientos[index],
                        //               );
                        //             },
                        //             // shrinkWrap: true,
                        //           ),
                        // ),
                      ),
                      20.pv,
                      Center(
                        child: ElevatedButton(
                          onPressed: Get.back,
                          child: const Text('Cerrar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
        isScrollControlled: true,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: AvistamientoHeatmap(
          additionalStackWidgets: [
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: Get.back,
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  final locationController = Get.find<LocationController>();
                  locationController.mapController.move(
                    LatLng(
                      locationController.latitud.value,
                      locationController.longitud.value,
                    ),
                    12.5,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                ),
                child: const Icon(Icons.my_location, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.info, color: Colors.black),
                onPressed: showAvistamientosRecientes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

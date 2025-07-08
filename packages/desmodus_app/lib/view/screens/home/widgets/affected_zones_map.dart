import 'package:flutter/material.dart';

class AffectedZonesMap extends StatelessWidget {
  const AffectedZonesMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey..withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Aquí iría el mapa real con flutter_map o google_maps_flutter
          // Por ahora uso un placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  'Mapa de zonas afectadas',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          
          // Botón de expandir
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black..withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.fullscreen, size: 20),
                onPressed: () {
                  // Navegar a vista completa del mapa
                },
              ),
            ),
          ),
          
          // Marcador de ejemplo
          const Positioned(
            bottom: 100,
            left: 150,
            child: Icon(
              Icons.location_on,
              color: Colors.black,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:ffi';

import 'package:desmodus_app/model/service/remote/news_service.dart';
import 'package:desmodus_app/view/ui/theme/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:desmodus_app/model/entity/news.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class CriticalZone {
  final LatLng center;
  final double radius;
  final String name;
  final int sightingCount;

  CriticalZone({
    required this.center,
    required this.radius,
    required this.name,
    required this.sightingCount,
  });
}

class SightingMarker {
  final LatLng location;
  final bool isCritical;
  final DateTime reportedAt;

  SightingMarker({
    required this.location,
    required this.isCritical,
    required this.reportedAt,
  });
}

class HomeController extends GetxController {
  // Lista observable de noticias
  final RxList<News> newsList = <News>[].obs;
  
  // Índice actual del bottom navigation
  final RxInt currentIndex = 0.obs;
  
  // Lista de IDs de noticias marcadas como importantes
  final RxList<int> importantNewsIds = <int>[].obs;
  
  // Ubicación del usuario
  final Rxn<LatLng> userLocation = Rxn<LatLng>();
  
  // Zonas críticas
  final RxList<CriticalZone> criticalZones = <CriticalZone>[].obs;
  
  // Marcadores de avistamientos
  final RxList<SightingMarker> sightingMarkers = <SightingMarker>[].obs;
  
  // Estado de zona crítica
  final RxBool isInCriticalZone = false.obs;
  
  // Notificaciones locales
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final NewsService _newsService = NewsService();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  List<News> get sortedNewsList {
  List<News> sorted = [...newsList];
  sorted.sort((a, b) {
    // Las importantes van primero
    bool aImportant = isNewsImportant(a.id);
    bool bImportant = isNewsImportant(b.id);
    
    if (aImportant && !bImportant) return -1;
    if (!aImportant && bImportant) return 1;
    
    return 0;
  });
  return sorted;
}

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _requestPermissions();
    loadNews();
    _loadCriticalZones();
    _startLocationTracking();
  }

  // Inicializar notificaciones
  void _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Solicitar permisos
  void _requestPermissions() async {
    await Permission.notification.request();
    await Permission.location.request();
  }

  // Rastrear ubicación del usuario
  void _startLocationTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Ubicación desactivada',
        'Activa la ubicación para recibir alertas de zonas críticas',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Escuchar cambios de ubicación
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100, // Actualizar cada 100 metros
      ),
    ).listen((Position position) {
      userLocation.value = LatLng(position.latitude, position.longitude);
      checkZoneAlert();
    });
  }

  // Cargar zonas críticas
  void _loadCriticalZones() {
    // Simulación de zonas críticas - En producción vendría del backend
    criticalZones.value = [
      CriticalZone(
        center: const LatLng(-12.1175, -77.0467),
        radius: 1000,
        name: 'San Martín de Porres',
        sightingCount: 15,
      ),
      CriticalZone(
        center: const LatLng(-12.0464, -77.0428),
        radius: 800,
        name: 'Los Olivos',
        sightingCount: 12,
      ),
    ];

    // Cargar marcadores de avistamientos
    sightingMarkers.value = [
      SightingMarker(
        location: const LatLng(-12.1180, -77.0470),
        isCritical: true,
        reportedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      SightingMarker(
        location: const LatLng(-12.0460, -77.0425),
        isCritical: false,
        reportedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  // Verificar si el usuario está en zona crítica
  void checkZoneAlert() {
    if (userLocation.value == null) return;

    bool wasInCriticalZone = isInCriticalZone.value;
    isInCriticalZone.value = false;

    for (var zone in criticalZones) {
      double distance = const Distance().as(
        LengthUnit.Meter,
        userLocation.value!,
        zone.center,
      );

      if (distance <= zone.radius) {
        isInCriticalZone.value = true;
        
        // Enviar notificación si acaba de entrar a la zona
        if (!wasInCriticalZone) {
          _sendCriticalZoneNotification(zone);
        }
        break;
      }
    }
  }

  // Enviar notificación de zona crítica
  void _sendCriticalZoneNotification(CriticalZone zone) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'critical_zones',
      'Zonas Críticas',
      channelDescription: 'Alertas de zonas con alta presencia de murciélagos',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );
    
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await flutterLocalNotificationsPlugin.show(
      0,
      '⚠️ Alerta de Zona Crítica',
      'Estás en ${zone.name} - Zona con ${zone.sightingCount} avistamientos recientes',
      platformChannelSpecifics,
    );

    // Mostrar también un diálogo en la app
    Get.dialog(
      AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Zona Crítica'),
          ],
        ),
        content: Text(
          'Has ingresado a ${zone.name}, una zona con alta presencia de murciélagos.\n\n'
          'Recomendaciones:\n'
          '• Mantén las ventanas cerradas\n'
          '• Evita dejar alimentos expuestos\n'
          '• Reporta cualquier avistamiento',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Entendido'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // Cargar noticias
  void loadNews() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final newsFromBackend = await _newsService.getAllNews();
      newsList.value = newsFromBackend;
      
      // Verificar noticias urgentes
      // _checkForUrgentNews();
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'No se pudieron cargar las noticias',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.dangerColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refrescar noticias
  Future<void> refreshNews() async {
    loadNews();
  }

  // Verificar noticias urgentes
  // void _checkForUrgentNews() {
  //   final urgentNews = newsList.where((news) => news.isUrgent).toList();
    
  //   for (var news in urgentNews) {
  //     _sendUrgentNewsNotification(news);
  //   }
  // }

  // Enviar notificación de noticia urgente
  void _sendUrgentNewsNotification(News news) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'urgent_news',
      'Noticias Urgentes',
      channelDescription: 'Notificaciones de noticias urgentes sobre murciélagos',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
    );
    
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await flutterLocalNotificationsPlugin.show(
      news.id.hashCode,
      '🚨 ${news.title}',
      news.description,
      platformChannelSpecifics,
    );
  }

  // Marcar/desmarcar noticia como importante
void toggleImportantNews(int newsId) {
  if (importantNewsIds.contains(newsId)) {
    importantNewsIds.remove(newsId);
    Get.snackbar(
      '✓ Removido',
      'Noticia removida de importantes',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
    );
  } else {
    importantNewsIds.add(newsId);
    Get.snackbar(
      '! Importante',
      'Noticia marcada como importante',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.warningColor,
      colorText: Colors.white,
    );
  }
}

  // Verificar si una noticia está marcada como importante
  bool isNewsImportant(int newsId) {
    return importantNewsIds.contains(newsId);
  }

  // Compartir noticia
  void shareNews(News news) {
    // Aquí implementarías la lógica para compartir
    Get.snackbar(
      'Compartir',
      'Compartiendo: ${news.title}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Navegar al detalle de la noticia
  void navigateToNewsDetail(News news) {
    Get.toNamed('/news-detail', arguments: news);
  }

  // Manejar tap en el bottom navigation
  void onBottomNavTap(int index) {
    currentIndex.value = index;
    
    switch (index) {
      case 0:
        // Ya estamos en home
        break;
      case 1:
        Get.toNamed('/detector');
        break;
      case 2:
        // Get.toNamed('/settings');
        Get.snackbar(
          'Navegación',
          'Ir a ajustes',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
    }
  }

  @override
  void onClose() {
    // Limpiar recursos si es necesario
    super.onClose();
  }
}
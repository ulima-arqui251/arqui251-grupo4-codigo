import 'package:get/get.dart';
import 'package:desmodus_app/model/entity/news.dart';

class HomeController extends GetxController {
  // Lista observable de noticias
  final RxList<News> newsList = <News>[].obs;
  
  // Índice actual del bottom navigation
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  // Cargar noticias (por ahora con datos de ejemplo)
  void loadNews() {
    // Aquí irías a buscar las noticias desde tu servicio/repositorio
    newsList.value = [
      News(
        id: '1',
        title: 'Como reportar especies avistadas al SENASA',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce placerat nulla felis, ac efficitur dui faucibus consectetur. Nam',
        imageUrl: null, // Aquí iría la URL real de la imagen del murciélago
      ),
      News(
        id: '2',
        title: 'Hábitat del murciélago vampiro',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce placerat nulla felis, ac efficitur dui faucibus consectetur. Nam',
        imageUrl: null, // Aquí iría la URL real de la imagen
      ),
    ];
  }

  // Navegar al detalle de la noticia
  void navigateToNewsDetail(News news) {
    // Get.toNamed('/news-detail', arguments: news);
    // Por ahora solo mostramos un mensaje
    Get.snackbar(
      'Navegación',
      'Ir al detalle de: ${news.title}',
      snackPosition: SnackPosition.BOTTOM,
    );
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
}
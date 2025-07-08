import 'package:desmodus_app/view/ui/theme/colors.dart';
import 'package:desmodus_app/view/ui/theme/fonts.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart'
    show AuthController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/view/screens/home/widgets/news_card.dart';
import 'package:desmodus_app/view/screens/home/widgets/affected_zones_map.dart';
import 'package:desmodus_app/view/screens/home/widgets/district_ranking.dart';
import 'package:desmodus_app/viewmodel/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.chat_bubble_outline, size: 28),
            onPressed: () => Get.toNamed("chatbot"),
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Desmodus App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección de últimas noticias
                // Sección de últimas noticias
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 18),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Hola ${authController.userPayload["name"]}!",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
      const Text(
        'Últimas noticias',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
      const SizedBox(height: 16),
      Obx(() {
        // Estado de carga
        if (controller.isLoading.value) {
          return Container(
            height: 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // Estado de error
        if (controller.errorMessage.value.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppColors.dangerColor,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error al cargar noticias',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dangerColor,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.primaryFont,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => controller.refreshNews(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }
        
        // Estado sin noticias
        if (controller.sortedNewsList.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Icon(
                  Icons.article_outlined,
                  color: Colors.grey[400],
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay noticias disponibles',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ],
            ),
          );
        }
        
        // Lista de noticias
        return Column(
          children: controller.sortedNewsList
              .map(
                (news) => NewsCard(
                  news: news,
                  onTap: () => controller.navigateToNewsDetail(news),
                ),
              )
              .toList(),
        );
      }),
    ],
  ),
),

                // Sección de zonas afectadas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Zonas afectadas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const AffectedZonesMap(),
                    ],
                  ),
                ),

                // Sección de ranking de distritos
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ranking de distritos más afectados',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const DistrictRanking(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: Colors.grey,
                  currentIndex: 0,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Feed',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox.shrink(), // Espacio vacío para el FAB
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Ajustes',
                    ),
                  ],
                  onTap: controller.onBottomNavTap,
                ),
              ),
              // Botón flotante central
              Positioned(
                bottom: 40,
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.onBottomNavTap(1),
                      customBorder: const CircleBorder(),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

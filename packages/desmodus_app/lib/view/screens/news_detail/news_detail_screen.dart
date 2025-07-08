import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/view/ui/theme/colors.dart';
import 'package:desmodus_app/view/ui/theme/fonts.dart';
import 'package:desmodus_app/viewmodel/controllers/news_detail_controller.dart';

class NewsDetailScreen extends GetView<NewsDetailController> {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar con imagen
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen de fondo
                  controller.news.imageUrl != null
                      ? Image.network(
                        controller.news.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 80,
                            ),
                          );
                        },
                      )
                      : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 80,
                        ),
                      ),
                  // Gradiente oscuro
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Botones de acción
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    right: 16,
                    child: Row(
                      children: [
                        // Botón de compartir
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () => controller.shareNews(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Botón de importante
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color:
                                  controller.isImportant.value
                                      ? AppColors.warningColor
                                      : Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Text(
                                '!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                              onPressed: () => controller.toggleImportant(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Contenido
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fecha y autor
                  if (controller.news.publishedAt != null ||
                      controller.news.author != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          if (controller.news.publishedAt != null)
                            Text(
                              controller.formatDate(
                                controller.news.publishedAt!,
                              ),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          if (controller.news.publishedAt != null &&
                              controller.news.author != null)
                            Text(
                              ' • ',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          if (controller.news.author != null)
                            Text(
                              controller.news.author!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                        ],
                      ),
                    ),

                  // Título
                  Text(
                    controller.news.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.primaryFont,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  Text(
                    controller.news.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontFamily: AppFonts.primaryFont,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Contenido completo
                  if (controller.news.content != null)
                    Text(
                      controller.news.content!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.primaryFont,
                        height: 1.6,
                      ),
                    ),

                  const SizedBox(height: 32),

                  // Sección de recomendaciones
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Recomendaciones',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Mantén las ventanas cerradas durante la noche\n'
                          '• Evita dejar alimentos expuestos\n'
                          '• Reporta cualquier avistamiento al SENASA\n'
                          '• Vacuna a tus mascotas contra la rabia',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontFamily: AppFonts.primaryFont,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Botón de reportar avistamiento
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/detector'),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text(
                        'Reportar Avistamiento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

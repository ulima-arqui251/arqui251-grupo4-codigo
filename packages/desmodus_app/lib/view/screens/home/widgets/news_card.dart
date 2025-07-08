import 'package:flutter/material.dart';
import 'package:desmodus_app/model/entity/news.dart';
import 'package:desmodus_app/view/ui/theme/colors.dart';
import 'package:desmodus_app/view/ui/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/viewmodel/controllers/home_controller.dart';

class NewsCard extends GetView<HomeController> {
  final News news;
  final VoidCallback onTap;

  const NewsCard({
    Key? key,
    required this.news,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: news.imageUrl != null
                        ? Image.network(
                            news.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              );
                            },
                          )
                        : const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 40,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                // Contenido
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.primaryFont,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: AppFonts.primaryFont,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botón de importante en la esquina superior derecha
          Positioned(
            top: -8,
            right: -7,
            child: Obx(() => GestureDetector(
              onTap: () => controller.toggleImportantNews(news.id),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isNewsImportant(news.id)
                      ? AppColors.warningColor
                      : Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: controller.isNewsImportant(news.id)
                          ? Colors.white
                          : Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
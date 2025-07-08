import 'package:get/get.dart';
import 'package:desmodus_app/model/entity/news.dart';
import 'package:desmodus_app/viewmodel/controllers/home_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class NewsDetailController extends GetxController {
  late News news;
  late RxBool isImportant;
  
  // Referencia al HomeController para sincronizar el estado
  final HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    // Obtener la noticia pasada como argumento
    news = Get.arguments as News;
    
    // Inicializar el estado de importante
    isImportant = homeController.isNewsImportant(news.id).obs;
  }

  // Formatear fecha
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'Hace ${difference.inMinutes} minutos';
      } else {
        return 'Hace ${difference.inHours} horas';
      }
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // Marcar/desmarcar como importante
  void toggleImportant() {
    homeController.toggleImportantNews(news.id);
    isImportant.value = !isImportant.value;
  }

  // Compartir noticia
  void shareNews() {
    final String shareText = '''
                            ${news.title}

                            ${news.description}

                            Lee más en la app Desmodus
                              ''';
    
    Share.share(shareText);
  }
}
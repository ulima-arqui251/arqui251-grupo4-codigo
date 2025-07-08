import 'package:dio/dio.dart';
import 'package:desmodus_app/config.dart';
import 'package:desmodus_app/model/entity/news.dart';

class NewsService {
  final Dio _dio;
  final String baseUrl;

  NewsService() : 
    _dio = Dio(),
    baseUrl = 'http://10.0.2.2:8054'; // Para Android Emulator
    // baseUrl = 'http://localhost:8054'; // Para web/iOS
    // baseUrl = Config.apiUrl; // Si tienes configuración centralizada

  // Obtener todas las noticias
  Future<List<News>> getAllNews({int skip = 0, int limit = 10}) async {
    try {
      final response = await _dio.get(
        '$baseUrl/noticias',
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar noticias');
      }
    } on DioException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    }
  }

  // Obtener noticia por ID
  Future<News> getNewsById(int id) async {
    try {
      final response = await _dio.get('$baseUrl/noticias/$id');

      if (response.statusCode == 200) {
        return News.fromJson(response.data);
      } else {
        throw Exception('Noticia no encontrada');
      }
    } on DioException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    }
  }

  // Crear nueva noticia (para futuro uso)
  Future<News> createNews({
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/noticias',
        queryParameters: {
          'title': title,
          'content': content,
          if (imageUrl != null) 'image_url': imageUrl,
        },
      );

      if (response.statusCode == 200) {
        return News.fromJson(response.data);
      } else {
        throw Exception('Error al crear noticia');
      }
    } on DioException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    }
  }
}
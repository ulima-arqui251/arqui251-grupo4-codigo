import 'dart:convert';
import 'package:http/http.dart' as http;

class AssistantService {
  final String baseUrl;

  AssistantService({
    this.baseUrl = 'http://localhost:8000',
  }); // cambia según sea necesario

  Future<String> preguntarChatbot(String message) async {
    final uri = Uri.parse(
      '$baseUrl/chat?prompt=${Uri.encodeComponent(message)}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['output'] ?? 'Sin respuesta del chatbot.';
    } else {
      return 'Error del servidor: ${response.statusCode}';
    }
  }
}

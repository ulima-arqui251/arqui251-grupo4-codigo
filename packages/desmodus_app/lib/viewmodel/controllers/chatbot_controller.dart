import 'package:get/get.dart';
import 'package:desmodus_app/model/entity/local_message.dart';
import 'package:desmodus_app/model/service/remote/chatbot_service.dart';

class AssistantController extends GetxController {
  final service = AssistantService();
  final isLoading = false.obs;
  final messages = <LocalMessage>[].obs;

  Future<void> cargarHistorial() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      messages.value = [];
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> enviarMensaje(LocalMessage message) async {
    messages.add(message);
    try {
      final consulta = message.message;

      String respuestaBot = "";

      var repsonse = LocalMessage(
        sender: "DesmodusBot",
        message: respuestaBot,
        createdAt: DateTime.now(),
      );

      messages.add(repsonse);
      final messageIndex = messages.length - 1;

      final botResponse = await service.preguntarChatbot(consulta);
      messages[messageIndex] = LocalMessage(
        message: botResponse,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print("Algo salió mal $e");
      printError();
    }
  }
}

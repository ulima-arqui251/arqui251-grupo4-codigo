class AssistantService {
  Future<String> preguntarChatbot(String message) async {
    await Future.delayed(Duration(seconds: 1));
    return "Response from chatbot for message: $message";
  }
}

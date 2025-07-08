import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/utils/cookies.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart';

class AuthCallbackScreen extends StatelessWidget {
  final String jwt;

  const AuthCallbackScreen({super.key, required this.jwt});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    Future<bool> verifyAuthCallback() async {
      try {
        storeCookie("access_token", jwt);
        await controller.actualizarInfoUsuario();
        print("Autorización exitosa: $jwt");
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

    return FutureBuilder<bool>(
      future: verifyAuthCallback(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          Get.snackbar(
            'Error',
            'Algo salió mal durante la autenticación.',
            snackPosition: SnackPosition.TOP,
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAndToNamed("/login");
          });
          return const SizedBox.shrink();
        } else if (snapshot.hasData && snapshot.data == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAndToNamed("/home");
          });
          return Scaffold(
            body: const Center(
              child: Text('Conexión exitosa'),
            ),
          );
        } else {
          Get.snackbar(
            'Error',
            'Algo salió mal.',
            snackPosition: SnackPosition.TOP,
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAndToNamed("/login");
          });
          return const Center(
            child: Text('Algo salió mal.'),
          );
        }
      },
    );
  }
}

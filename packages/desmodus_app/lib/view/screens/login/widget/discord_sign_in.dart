import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart'
    show AuthController;

class DiscordSignInButton extends StatelessWidget {
  const DiscordSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(
      () => ElevatedButton(
        onPressed: authController.isLoading.value
            ? null
            : () => authController.iniciarSesionConDs(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.discord),
            const SizedBox(width: 8),
            const Text('Inicia sesión con Discord'),
          ],
        ),
        // child: const Text('Discord login'),
      ),
    );
  }
}

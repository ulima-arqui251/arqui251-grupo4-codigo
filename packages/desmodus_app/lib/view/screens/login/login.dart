import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/utils/padding_extensions.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desmodus App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/image/logo.png'),
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.iniciarSesionConGoogle(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/image/google.svg',
                    width: 15.0,
                    height: 15.0,
                  ),
                  const SizedBox(width: 8),
                  const Text('Inicia sesión con Google'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.iniciarSesionConDs(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.discord),
                  const SizedBox(width: 8),
                  const Text('Inicia sesión con Discord'),
                ],
              ),
            ),
            20.pv,
            // - o - Divider
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            20.pv,
            ElevatedButton(
              onPressed: () => controller.iniciarSesionConDs(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  const Text('Ingresar sin detección'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';
import 'package:desmodus_app/viewmodel/auth_controller.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class CuestionarioScreen extends StatefulWidget {
  const CuestionarioScreen({super.key});

  @override
  State<CuestionarioScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<CuestionarioScreen> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Completa tu información',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SvgPicture.asset(
              'assets/image/logo.svg',
              width: 200.0,
              height: 200.0,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.usuarioCompleto.value = true;
                print("Usuario completo: ${controller.usuarioCompleto.value}");
                Get.offNamed("/home");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text('Confirmar')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

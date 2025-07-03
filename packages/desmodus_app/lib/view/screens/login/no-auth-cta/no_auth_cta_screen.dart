import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/utils/padding_extensions.dart';
import 'package:desmodus_app/view/screens/login/no-auth-cta/widget/features_carousel.dart'
    show FeaturesCarouselWidget;

class NoAuthCtaScreen extends StatelessWidget {
  const NoAuthCtaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "¿Por qué iniciar sesión?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              10.pv,
              SizedBox(height: 600, child: FeaturesCarouselWidget()),
              10.pv,
              Text(
                'Inicia sesión para disfrutar de todas las funcionalidades.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              10.pv,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Regresar'),
                  ),
                  10.ph,
                  ElevatedButton(
                    onPressed: () => Get.offAndToNamed("/detector"),
                    child: const Text('Continuar a detector'),
                  ),
                  10.ph,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

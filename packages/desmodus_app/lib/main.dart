import 'package:desmodus_app/config.dart';
import 'package:desmodus_app/router.dart';
import 'package:desmodus_app/utils/global.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GlobalApp.init();

  const firstScreen = "/login";

  runApp(MainApp(firstScreen: firstScreen));
}

class MainApp extends StatelessWidget {
  final String firstScreen;
  const MainApp({super.key, required this.firstScreen});

  @override
  Widget build(BuildContext context) {
    if (Config.ambiente == "UNAUTHORIZED") {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Expanded(
            child: Center(
              child: Text(
                "No se han podido leer las variables de entorno, reucerda usar un .env",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    return getAppRouter(firstScreen);
  }
}

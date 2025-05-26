import 'package:get/route_manager.dart';
import 'package:desmodus_app/view/screens/login/login_screen.dart';
import 'package:desmodus_app/view/screens/login/no-auth-cta/no_auth_cta_screen.dart';
import 'package:desmodus_app/view/ui/theme/theme.dart';

GetMaterialApp getAppRouter(String firstScreen) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lissachatina App',
    theme: appTheme,
    darkTheme: darkAppTheme,
    initialRoute: firstScreen,
    getPages: [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        children: [
          GetPage(name: '/no-auth-cta', page: () => const NoAuthCtaScreen()),
        ],
      ),
      //   GetPage(
      //     name: '/location-map',
      //     page: () => const LocationMapFullScreen(),
      //   ),
      //   GetPage(
      //     name: '/camera',
      //     page: () => const UltralyticsCameraScreen(),
      //     bindings: [
      //       CameraBindings(),
      //     ],
      //   ),
      //   GetPage(
      //     name: '/cuestionario',
      //     page: () => const CuestionarioScreen(),
      //   ),
      //   GetPage(
      //       name: '/dashboard',
      //       page: () => const DashboardScreen(),
      //       middlewares: [
      //         AuthGuard()
      //       ],
      //       bindings: [
      //         // AuthBindings(),
      //         DashboardBindings(),
      //       ]),
      // ],
      // initialBinding: AuthBindings(),
    ],
  );
}

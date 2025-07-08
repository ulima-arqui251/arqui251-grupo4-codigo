import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/view/screens/login/login_screen.dart';
import 'package:desmodus_app/view/screens/login/no-auth-cta/no_auth_cta_screen.dart';
import 'package:desmodus_app/view/screens/chatbot/chatbot_screen.dart'
    show ChatbotScreen;
import 'package:desmodus_app/view/screens/detector/detector_screen.dart';
import 'package:desmodus_app/view/screens/heatmap/heatmap_screen.dart';
import 'package:desmodus_app/view/screens/cuestionario/cuestionario_screen.dart';
import 'package:desmodus_app/view/ui/theme/theme.dart';
import 'package:desmodus_app/viewmodel/bindings/initial_bindings.dart';
import 'package:desmodus_app/viewmodel/bindings/auth_bindings.dart';
import 'package:desmodus_app/viewmodel/controllers/location_controller.dart';
import 'package:desmodus_app/viewmodel/controllers/sightings/remote_sightings_controller.dart';
import 'package:desmodus_app/viewmodel/middleware/auth_guard.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/view/screens/login/login_screen.dart';
import 'package:desmodus_app/view/screens/login/no-auth-cta/no_auth_cta_screen.dart';
import 'package:desmodus_app/view/ui/theme/theme.dart';

GetMaterialApp getAppRouter(String firstScreen) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Desmodus App',
    theme: appTheme,
    darkTheme: darkAppTheme,
    initialRoute: firstScreen,
    getPages: [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        binding: AuthBindings(),
        children: [
          GetPage(
            name: '/no-auth-cta',
            page: () => const NoAuthCtaScreen(),
          ),
        ],
      ),
      GetPage(
        name: '/detector',
        page: () => const DetectorScreen(),
        // bindings: [],
      ),
      GetPage(
        name: '/chatbot',
        page: () => const ChatbotScreen(),
        // bindings: [],
      ),
      GetPage(
        name: '/heatmap',
        page: () => const HeatmapScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RemoteSightingsController());
          Get.lazyPut(() => LocationController());
        }),
      ),
      GetPage(
        name: '/cuestionario',
        page: () => const CuestionarioScreen(),
      ),
      //  GetPage(
      //    name: '/location-map',
      //    page: () => const LocationMapFullScreen(),
      //  )
      //  GetPage(
      //    name: '/dashboard',
      //    page: () => const DashboardScreen(),
      //    middlewares: [
      //      AuthGuard()
      //    ],
      //    bindings: [
      //      DashboardBindings(),
      //    ],
      //  ),
    ],
    initialBinding: InitialBindings(),
  );
}
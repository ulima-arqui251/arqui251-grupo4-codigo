import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desmodus_app/utils/cookies.dart' show getCookie;

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final accessToken = getCookie("access_token");

    if (accessToken == null || accessToken.isEmpty) {
      // print("Token de acceso no encontrado, redirigiendo a /login");
      return const RouteSettings(name: '/login');
    }

    // print("Token de acceso encontrado, permitiendo el acceso a $route");
    return null;
  }
}

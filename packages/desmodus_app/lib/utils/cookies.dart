import 'package:desmodus_app/utils/global.dart';

void storeCookie(String cookieName, String cookieValue) {
  GlobalApp.localStorage!.setString(cookieName, cookieValue);
}

String? getCookie(String cookieName) {
  return GlobalApp.localStorage!.getString(cookieName);
}

void deleteCookie(String cookieName) {
  GlobalApp.localStorage!.remove(cookieName);
}

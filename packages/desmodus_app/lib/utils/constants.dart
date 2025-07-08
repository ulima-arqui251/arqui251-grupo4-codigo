import 'package:flutter/widgets.dart';

Future<String> appVersion(BuildContext context) {
  final bundle = DefaultAssetBundle.of(context);
  // or use root bundle if no BuildContext is available
  return bundle.loadString("pubspec.yaml").then((res) {
    final version = res.split("version: ")[1].split(RegExp(r'\s+'))[0].trim();
    return version;
  }).catchError((err) {
    return "NaN";
  });
}

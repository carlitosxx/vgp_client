import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/my_app.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));

  runApp(const MyApp()
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MyApp(), // Wrap your app
      // ),
      );
}

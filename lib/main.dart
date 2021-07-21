import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorbin_restaurant/bindings/home_binding.dart';
import 'package:tutorbin_restaurant/screens/home_screen.dart';
import 'package:tutorbin_restaurant/utils/Strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen(), binding: HomeBinding())
      ],
    );
  }
}

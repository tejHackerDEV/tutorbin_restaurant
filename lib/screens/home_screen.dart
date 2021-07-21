import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorbin_restaurant/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>().fetchMenu(); // fetch menu
    return Container();
  }
}

import 'package:get/get.dart';
import 'package:tutorbin_restaurant/controllers/home_controller.dart';
import 'package:tutorbin_restaurant/repo/home_repo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(Get.put(HomeRepo())));
  }
}

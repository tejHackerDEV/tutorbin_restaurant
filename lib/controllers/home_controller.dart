import 'package:get/get.dart';
import 'package:tutorbin_restaurant/models/category.dart';
import 'package:tutorbin_restaurant/repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo _repo;
  HomeController(this._repo);

  final isFetching =
      false.obs; // used to know whether app is requesting data from repo
  RxList<Category> categories = RxList.empty();

  final totalPrice = 0.toDouble().obs;

  /// Fetches Menu from the repo
  void fetchMenu() async {
    if (isFetching.isFalse) isFetching.toggle(); // notify data is fetching
    categories.addAll(await _repo.fetchMenu()); // add items to categories
    if (isFetching.isTrue)
      isFetching.toggle(); // notify data fetching is completed
  }

  void addToCart({required int categoryIndex, required int itemIndex}) {
    final item = categories[categoryIndex].items[itemIndex];
    totalPrice.value += item.price;
    item.count++;
    categories.refresh();
  }

  void removeFromCart({required int categoryIndex, required int itemIndex}) {
    final item = categories[categoryIndex].items[itemIndex];
    totalPrice.value -= item.price;
    item.count--;
    categories.refresh();
  }
}

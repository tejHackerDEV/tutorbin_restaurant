import 'package:get/get.dart';
import 'package:tutorbin_restaurant/models/category.dart';
import 'package:tutorbin_restaurant/models/order.dart';
import 'package:tutorbin_restaurant/repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo _repo;
  HomeController(this._repo);

  final isFetching =
      false.obs; // used to know whether app is requesting data from repo
  RxList<Category> categories = RxList.empty();

  final totalPrice = 0.toDouble().obs;

  final List<Order> cartItems = [];

  /// Fetches Menu from the repo
  void fetchMenu() async {
    totalPrice.value = 0;
    categories.clear();
    cartItems.clear();
    if (isFetching.isFalse) isFetching.toggle(); // notify data is fetching
    categories.addAll(await _repo.fetchMenu()); // add items to categories
    if (isFetching.isTrue)
      isFetching.toggle(); // notify data fetching is completed
  }

  /// Add item to cart
  void addToCart({required int categoryIndex, required int itemIndex}) {
    final item = categories[categoryIndex].items[itemIndex];
    totalPrice.value += item.price;
    item.count++;
    cartItems.add(
      Order(
        null,
        item.name,
        item.price,
        DateTime.now().millisecondsSinceEpoch,
        false,
      ),
    );
    categories.refresh();
  }

  /// Remove item from cart
  void removeFromCart({required int categoryIndex, required int itemIndex}) {
    final item = categories[categoryIndex].items[itemIndex];
    totalPrice.value -= item.price;
    item.count--;
    // remove item from cart
    for (int i = cartItems.length - 1; i >= 0; --i) {
      final element = cartItems[i];
      if (element.name.toLowerCase() == item.name.toLowerCase()) {
        cartItems.removeAt(i);
        break;
      }
    }
    categories.refresh();
  }

  /// Places order with the items in the cart
  Future placeOrder() async {
    if (cartItems.isNotEmpty) {
      await _repo.placeOrder(cartItems);
    }
    fetchMenu();
  }
}

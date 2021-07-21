import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutorbin_restaurant/models/category.dart';
import 'package:tutorbin_restaurant/models/item.dart';
import 'package:tutorbin_restaurant/models/order.dart';

class HomeRepo {
  final OrderProvider _orderProvider;
  HomeRepo(this._orderProvider);

  Future<List<Category>> fetchMenu() {
    // retrieve data after 3seconds to mimic like fetching from api
    return Future.delayed(const Duration(seconds: 3), () async {
      List<Category> categories = [];

      // Open Database Connection
      final databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'tutorbin.db');
      await _orderProvider.open(path);
      List<Order> topThreeOrders = await _orderProvider.getTopThreeOrders();
      List<Item> topThreeItems = []; // to store top three items

      // iterate menu & add them to list based on categories
      Menu.forEach((key, value) {
        List<Item> items = [];
        value.forEach((element) {
          final item = Item(
            element['name'].toString(),
            (element['price'] as int).toDouble(),
            element['instock'] as bool,
            false,
          );

          // add top items
          // if top three items already added don't do anything
          if (topThreeItems.length != 3) {
            for (int i = 0; i < topThreeOrders.length; ++i) {
              final topOrder = topThreeOrders[i];
              if (topOrder.name.toLowerCase() == item.name.toLowerCase()) {
                topThreeItems.add(item); // add the item to the top three items

                // if the order is best seller then mark the item as bestSeller
                if (topOrder.isBestSeller) {
                  item.isBestSeller = true;
                }
              }
            }
          }

          // add normal items
          items.add(item);
        });
        categories.add(Category(key, items));
      });

      // finally add top items if they are not empty
      if (topThreeItems.isNotEmpty) {
        categories.insert(0, Category('Popular Items', topThreeItems));
      }
      return categories;
    });
  }

  Future placeOrder(List<Order> orders) async {
    await _orderProvider.insertAll(orders);
  }
}

const Menu = {
  'cat1': [
    {'name': 'XYZ', 'price': 100, 'instock': true},
    {'name': 'ABC', 'price': 934, 'instock': false},
    {'name': 'OTR', 'price': 945, 'instock': true},
    {'name': 'SLG', 'price': 343, 'instock': true},
    {'name': 'KGN', 'price': 342, 'instock': true},
    {'name': 'GDS', 'price': 234, 'instock': true},
    {'name': 'KNL', 'price': 934, 'instock': true},
    {'name': 'GLM', 'price': 320, 'instock': true},
    {'name': 'DKF', 'price': 394, 'instock': false},
    {'name': 'VFS', 'price': 854, 'instock': true},
  ],
  'cat2': [
    {'name': 'NA', 'price': 124, 'instock': true},
    {'name': 'DS', 'price': 953, 'instock': true},
    {'name': 'HF', 'price': 100, 'instock': true},
    {'name': 'FJ', 'price': 583, 'instock': true},
    {'name': 'LS', 'price': 945, 'instock': false},
    {'name': 'TR', 'price': 394, 'instock': true},
    {'name': 'PD', 'price': 35, 'instock': true},
    {'name': 'AL', 'price': 125, 'instock': true},
    {'name': 'TK', 'price': 129, 'instock': true},
    {'name': 'PG', 'price': 294, 'instock': true},
  ],
  'cat3': [
    {'name': 'A', 'price': 294, 'instock': true},
    {'name': 'B', 'price': 125, 'instock': true},
    {'name': 'C', 'price': 256, 'instock': true},
    {'name': 'D', 'price': 100, 'instock': true},
    {'name': 'E', 'price': 100, 'instock': true},
    {'name': 'F', 'price': 530, 'instock': true},
    {'name': 'G', 'price': 100, 'instock': true},
    {'name': 'H', 'price': 100, 'instock': true},
    {'name': 'I', 'price': 395, 'instock': true},
  ],
  'cat4': [
    {'name': 'J', 'price': 100, 'instock': true},
    {'name': 'K', 'price': 100, 'instock': true},
    {'name': 'L', 'price': 125, 'instock': false},
    {'name': 'M', 'price': 530, 'instock': true},
    {'name': 'N', 'price': 100, 'instock': true},
    {'name': 'O', 'price': 395, 'instock': true},
    {'name': 'P', 'price': 100, 'instock': true},
    {'name': 'Q', 'price': 400, 'instock': true},
    {'name': 'R', 'price': 100, 'instock': true},
    {'name': 'S', 'price': 256, 'instock': true},
  ],
  'cat5': [
    {'name': 'T', 'price': 100, 'instock': false},
    {'name': 'U', 'price': 100, 'instock': true},
    {'name': 'V', 'price': 395, 'instock': true},
    {'name': 'W', 'price': 100, 'instock': true},
    {'name': 'X', 'price': 100, 'instock': false},
    {'name': 'Y', 'price': 125, 'instock': true},
    {'name': 'Z', 'price': 530, 'instock': true},
  ],
  'cat6': [
    {'name': 'ABCD', 'price': 400, 'instock': true},
    {'name': 'PROS', 'price': 256, 'instock': true},
    {'name': 'NFDD', 'price': 200, 'instock': true},
    {'name': 'LFKR', 'price': 200, 'instock': true},
  ]
};

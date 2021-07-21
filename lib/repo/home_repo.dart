import 'package:tutorbin_restaurant/models/category.dart';
import 'package:tutorbin_restaurant/models/item.dart';

class HomeRepo {
  Future<List<Category>> fetchMenu() {
    // retrieve data after 3seconds to mimic like fetching from api
    return Future.delayed(const Duration(seconds: 3), () {
      List<Category> categories = [];
      // iterate menu & add them to list based on categories
      Menu.forEach((key, value) {
        List<Item> items = [];
        value.forEach((element) {
          items.add(
            Item(
              element['name'].toString(),
              double.parse(element['price'].toString()),
              element['inStock'].toString().toLowerCase() == 'true',
            ),
          );
        });
        categories.add(Category(key, items));
      });
      return categories;
    });
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

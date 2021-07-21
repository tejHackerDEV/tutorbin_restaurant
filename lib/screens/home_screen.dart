import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorbin_restaurant/controllers/home_controller.dart';
import 'package:tutorbin_restaurant/models/category.dart';
import 'package:tutorbin_restaurant/utils/Strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    controller.fetchMenu(); // fetch menu
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      body: SafeArea(
        child: Obx(() {
          final categories = controller.categories;
          return categories.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, categoryIndex) {
                    return _buildCategoryWithItems(
                        categories, categoryIndex, controller);
                  },
                  itemCount: categories.length,
                );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return Visibility(
          visible: controller.totalPrice > 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.placeOrder,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${Strings.rupeesSymbol} ${controller.totalPrice}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  /// Builds Expansion tiles of categories with items in it
  ExpansionTile _buildCategoryWithItems(
    final RxList<Category> categories,
    final int categoryIndex,
    final HomeController controller,
  ) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            categories[categoryIndex].name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${categories[categoryIndex].items.length.toString()} items',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
        ],
      ),
      children: categories[categoryIndex].items.asMap().entries.map(
        (entry) {
          final itemIndex = entry.key;
          final item = entry.value;
          return Container(
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(
                item.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${Strings.rupeesSymbol} ${item.price.toString()}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: GestureDetector(
                onTap: item.count == 0
                    ? () {
                        controller.addToCart(
                          categoryIndex: categoryIndex,
                          itemIndex: itemIndex,
                        );
                      }
                    : null,
                child: Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: item.count > 0,
                        child: GestureDetector(
                          onTap: () => controller.removeFromCart(
                            categoryIndex: categoryIndex,
                            itemIndex: itemIndex,
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        item.count == 0 ? Strings.add : item.count.toString(),
                      ),
                      SizedBox(width: 5.0),
                      Visibility(
                        visible: item.count > 0,
                        child: GestureDetector(
                          onTap: () => controller.addToCart(
                            categoryIndex: categoryIndex,
                            itemIndex: itemIndex,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

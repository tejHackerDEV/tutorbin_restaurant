import 'item.dart';

class Category {
  final String name;
  final List<Item> items;

  Category(this.name, this.items);

  @override
  String toString() {
    return '$name => ${items.toString()}';
  }
}

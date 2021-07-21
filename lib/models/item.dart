class Item {
  final String name;
  final double price;
  final bool inStock;
  int count = 0;

  Item(this.name, this.price, this.inStock);

  @override
  String toString() {
    return '{name: $name, price: $price, inStock: $inStock}';
  }
}

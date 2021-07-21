class Item {
  final String name;
  final double price;
  final bool inStock;
  int count = 0;
  bool isBestSeller;

  Item(this.name, this.price, this.inStock, this.isBestSeller);

  @override
  String toString() {
    return '{name: $name, price: $price, inStock: $inStock, isBestSeller: $isBestSeller}';
  }
}

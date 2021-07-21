import 'package:sqflite/sqflite.dart';

final String tableName = 'orders';
final String columnId = '_id';
final String columnName = 'name';
final String columnPrice = 'price';
final String columnOrderedTime = 'ordered_time';

class Order {
  final int? id;
  final String name;
  final double price;
  final int orderedTime;
  bool isBestSeller;

  Order(this.id, this.name, this.price, this.orderedTime, this.isBestSeller);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnPrice: price,
      columnOrderedTime: orderedTime,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Order.fromMap(Map<String, Object?> map)
      : id = map[columnId] as int,
        name = map[columnName] as String,
        price = map[columnPrice] as double,
        orderedTime = map[columnOrderedTime] as int,
        isBestSeller = false;
}

class OrderProvider {
  late Database db;

  /// opens database connection
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
              CREATE TABLE $tableName ( 
                  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
                  $columnName TEXT NOT NULL,
                  $columnPrice REAL NOT NULL,
                  $columnOrderedTime INTEGER NOT NULL
                )
              ''');
    });
  }

  /// Insert orders into db
  Future insertAll(List<Order> orders) async {
    Batch batch = db.batch();
    orders.forEach((order) {
      batch.insert(tableName, order.toMap());
    });
    await batch.commit();
  }

  /// Get's top three orders from the db
  Future<List<Order>> getTopThreeOrders() async {
    List<Map<String, Object?>> result = await db.rawQuery(
        'SELECT $columnId, $columnName, $columnPrice, $columnOrderedTime, COUNT($columnName) FROM $tableName GROUP BY $columnName ORDER BY COUNT($columnName) DESC LIMIT 3');
    List<Order> orders = [];
    result.forEach((element) {
      print(element.toString());
      orders.add(Order.fromMap(element));
    });

    // if orders are not empty then mark the first order as best seller
    if (orders.isNotEmpty) {
      orders.elementAt(0).isBestSeller = true;
    }
    return orders;
  }

  Future close() async => db.close();
}

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "dart:convert";

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    var url = Uri.parse(
        "https://maixshopdeleteit-default-rtdb.firebaseio.com/orders.json");
    var response = await http.post(url,
        body: json.encode({
          "amount": total,
          "products": cartProducts
              .map((e) => {
                    "id": e.id,
                    "title": e.title,
                    "quantity": e.quantity,
                    'price': e.price
                  })
              .toList(),
          "dateTime":timestamp.toIso8601String(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)["name"],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
  Future<void > fetchAndSetOrders()async{
    var url = Uri.parse(
        "https://maixshopdeleteit-default-rtdb.firebaseio.com/orders.json");
    http.Response response=await http.get(url) ;
    List<OrderItem> loadedItem=[];
    final extractedData=json.decode(response.body) as Map<String ,dynamic>;
    if(extractedData==null){
      return ;
    }
    extractedData.forEach((key, value) {loadedItem.add(OrderItem(id: key, amount: value["amount"],
        products:(value["products"]as List<dynamic> ).map((e) =>
            CartItem(id: e["id"], title: e["title"], quantity: e["quantity"], price: e["price"])).toList(),
        dateTime: DateTime.parse(value["dateTime"])));});
           _orders=loadedItem.reversed.toList();
           notifyListeners();
  }

}

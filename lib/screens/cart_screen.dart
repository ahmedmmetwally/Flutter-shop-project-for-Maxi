import 'package:flutter/material.dart';
import 'package:maxi_my_shop/providers/cart.dart' show Cart;
import 'package:maxi_my_shop/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("your cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Chip(
                      label: Text("\$${cart.totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {Provider.of<Orders>(context,listen:false).addOrder(cart.items.values.toList(),cart.totalAmount);
                      cart.clear();},
                      child: Text(
                        "ORDER NOW",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) => CartItem(
                    DateTime.now().toIso8601String(),
                    cart.items.keys.toList()[index],
                    cart.items.values.toList()[index].price,
                    cart.items.values.toList()[index].quantity,
                    cart.items.values.toList()[index].title),
                ),
          )
        ],
      ),
    );
  }
}

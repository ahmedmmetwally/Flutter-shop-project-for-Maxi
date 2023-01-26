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
                    orderButton(cart: cart)
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

class orderButton extends StatefulWidget {
  const orderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _orderButtonState createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed:
        (widget.cart.totalAmount<=0||_isLoading)?null:() async{
        setState((){
          _isLoading=true;
        });
     await Provider.of<Orders>(context,listen:false).addOrder(widget.cart.items.values.toList(),widget.cart.totalAmount);
        setState((){
          _isLoading=false;
        });
      widget.cart.clear();},
      child: _isLoading?CircularProgressIndicator():Text(
        "ORDER NOW",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );

  }
}

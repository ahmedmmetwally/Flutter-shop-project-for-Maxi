import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Icon(
          Icons.delete,
          color: Colors.black,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction)=>Provider.of<Cart>(context).removeItem(productId),
      confirmDismiss: (dirction){
        return showDialog(context: context,builder: (con)=>AlertDialog(title:Text("Are you sure?") ,
          content:Text("Do you want to remove this item from cart") , actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],));
      },
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: FittedBox(child: Text("\$$price")),
              ),
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text("total:\$${price * quantity}"),
              trailing: Text("$quantity X"),
            ),
          )),
    );
  }
}

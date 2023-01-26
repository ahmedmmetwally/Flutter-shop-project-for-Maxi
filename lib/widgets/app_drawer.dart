import 'package:flutter/material.dart';
import 'package:maxi_my_shop/screens/orders_screens.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: <Widget>[
      AppBar(
        title: Text('Hello Friend!'),
        automaticallyImplyLeading: false,
      ),
      Divider(),
      ListTile(leading: Icon(Icons.shop),title: Text("Shop"),onTap: ()=>Navigator.of(context).pushReplacementNamed("/"),),
      ListTile(leading: Icon(Icons.shop),title: Text("Shop"),onTap: ()=>Navigator.of(context).pushReplacementNamed(OrdersScreen.routName),),
      ListTile(leading: Icon(Icons.update),title: Text("manage product"),onTap: ()=>Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),)

    ],),);
  }
}

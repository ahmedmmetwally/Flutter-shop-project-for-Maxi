import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/orders.dart'show Orders;
import 'package:maxi_my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {
  static const routName="/OrdersScreen";
  @override
  Widget build(BuildContext context) {
   final orderData= Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title:Text("your Orders")),
      drawer:AppDrawer(),
      body:ListView.builder(itemCount:orderData.orders.length ,itemBuilder: (context,i)=>OrderItem(orderData.orders[i])) ,

    );
  }
}

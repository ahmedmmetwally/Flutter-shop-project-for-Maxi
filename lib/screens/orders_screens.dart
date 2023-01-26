import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/orders.dart'show Orders;
import 'package:maxi_my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {
  static const routName="/OrdersScreen";
  @override
  Widget build(BuildContext context) {
   //final orderData= Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title:Text("your Orders")),
      drawer:AppDrawer(),
      body:FutureBuilder(future: Provider.of<Orders>(context,listen:false).fetchAndSetOrders(),
        builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          child: CircularProgressIndicator();
        }else{
          if(snapshot.error!=null){
            return (Center(child: Text("There is an error"),));
          }else{
            return Consumer<Orders>(builder:(context ,orderData,child)=>
            ListView.builder(itemCount:orderData.orders.length ,itemBuilder: (context,i)=>OrderItem(orderData.orders[i])));
          }
        }
        },)
    );
  }
}

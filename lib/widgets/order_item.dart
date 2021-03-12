import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import"../providers/orders.dart"as ord;
class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}
bool _expanded=false;
class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.all(10),
    child: Column(children: <Widget>[
      ListTile(title:Text("\$${widget.order.amount}") ,
          subtitle: Text(DateFormat("dd MM yyyy hh:mm").format(widget.order.dateTime).toString()),
      trailing: IconButton(icon:Icon(_expanded?Icons.expand_less:Icons.expand_more),onPressed: (){setState(() {
        _expanded=!_expanded;
      });},)),
      SizedBox(height: 7,),
      if(_expanded)Container(height: min(widget.order.products.length*50.1,150),
        child: ListView(children: widget.order.products.map((prod)=>Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
          Text(prod.title,style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold)),
          Text("${prod.quantity}X\$${prod.price}",style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold))
        ],
        )).toList(),),)
    ],),);
  }
}

import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/products.dart';
import "package:provider/provider.dart";
class ProductDetailScreen extends StatelessWidget {
  static const routeName="/ProductDetailScreen";
  @override
  Widget build(BuildContext context) {
    String productId=ModalRoute.of(context).settings.arguments as String;
    final loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title:Text(loadedProduct.title)),
      body: SingleChildScrollView(child: Column(children:<Widget>[
        Container(height: 300,width:double.infinity,child: Image.network(loadedProduct.imageUrl,fit:BoxFit.cover)),
        SizedBox(height: 10,),
        Text("\$${loadedProduct.price}",style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold,fontSize: 17),textAlign: TextAlign.center,),
        SizedBox(height: 10,),
        Text(loadedProduct.description,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),textAlign:TextAlign.center,softWrap: true,),

      ]),)
    );
  }
}


import 'package:flutter/material.dart';
import 'package:maxi_my_shop/providers/product.dart';
import "package:provider/provider.dart";
import '../screens/product_detail_screen.dart';
import "../providers/cart.dart";

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
   final product= Provider.of<Product>(context,listen: false);
   final cart=Provider.of<Cart>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (context,product,child)=>IconButton(
            icon: Icon(product.isFavourite?Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () {product.toggleFavoriteStatus();},
          )),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {cart.addItem(product.id, product.price, product.title);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(content:Text(
              'Added item to cart!',textAlign: TextAlign.center,),duration: Duration(seconds: 2),
            action: SnackBarAction(label: "UNDOO", onPressed: (){cart.removeSingleItem(product.id);}),
              ));},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:maxi_my_shop/screens/product_detail_screen.dart';
//
//class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem(this.id, this.title, this.imageUrl);
//
//  @override
//  Widget build(BuildContext context) {
//    return ClipRRect(
//      borderRadius: BorderRadius.circular(10),
//      child: GridTile(
//        child: GestureDetector(
//          onTap: (){Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);},
//          child: Image.network(
//            imageUrl,
//            fit: BoxFit.cover,
//          ),
//        ),
//        footer: GridTileBar(
//          backgroundColor: Colors.black54,
//          title: Text(title,textAlign: TextAlign.center,),
//          leading: IconButton(color: Colors.red,icon: Icon(Icons.favorite_border), onPressed: null),
//          trailing: IconButton(color:Theme.of(context).accentColor,icon: Icon(Icons.add_shopping_cart), onPressed: null,),
//        ),
//      ),
//    );
//  }
//}

import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/cart.dart';
import 'package:maxi_my_shop/widgets/app_drawer.dart';
import 'package:maxi_my_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import "../widgets/badge.dart";
import "../screens/cart_screen.dart";
enum FilterOptions{
  Favorites,
  All,
}
class ProductsOverviewScreen extends StatefulWidget {
//  final List<Product> loadedProducts = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
//  ];
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("iam Product Screen"),actions: <Widget>[
        PopupMenuButton(icon: Icon(Icons.more_vert),onSelected: (FilterOptions filterOptions){
          setState(() {
            if(filterOptions==FilterOptions.Favorites){
              _showOnlyFavorites=true;
            }
            else {
              _showOnlyFavorites = false;
            }
          });
        },itemBuilder: (_)=>[
          PopupMenuItem(child: Text('Only Favorites'),value:FilterOptions.Favorites,),
          PopupMenuItem(child:Text("Show All"),value:FilterOptions.All)
        ],),
        Consumer<Cart>(builder: (context,cart,child)=>Badge(child:child
          ,value: cart.itemCount.toString(),),child:  IconButton(icon:Icon(Icons.shopping_cart)
          ,onPressed: ()=>Navigator.of(context).pushNamed(CartScreen.routName),),)
      ],
      ),
       drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ProductsGrid(_showOnlyFavorites),
      ),
    );
  }
}


//ProductItem(loadedProducts[index].id,
//loadedProducts[index].title, loadedProducts[index].imageUrl)

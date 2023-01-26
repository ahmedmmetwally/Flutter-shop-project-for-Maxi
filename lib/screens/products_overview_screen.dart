import "package:flutter/material.dart";
import 'package:maxi_my_shop/providers/cart.dart';
import 'package:maxi_my_shop/providers/products.dart';
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

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  bool _isInit=true;
  bool _isLoading=false;
  @override
  void didChangeDependencies() {
    if(_isInit){setState((){_isLoading=false;});
    Provider.of<Products>(context).fetchAndSetProducts().then((value) {setState((){_isLoading=false;});});}
   _isInit=false;
    super.didChangeDependencies();
  }


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
        child: _isLoading?Center(child: CircularProgressIndicator(),):ProductsGrid(_showOnlyFavorites),
      ),
    );
  }
}


//ProductItem(loadedProducts[index].id,
//loadedProducts[index].title, loadedProducts[index].imageUrl)

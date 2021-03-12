import 'package:flutter/material.dart';
import 'package:maxi_my_shop/providers/product.dart';
import 'package:maxi_my_shop/providers/products.dart';
import 'package:maxi_my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
bool _showOnlyFavorites;

ProductsGrid(this._showOnlyFavorites);

@override
  Widget build(BuildContext context) {
  final Products productsData = Provider.of<Products>(context);
   List<Product> productList=_showOnlyFavorites?productsData.favoriteItems:productsData.item;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value:productList[index] ,
          //builder: (context)=>productList[index],
          child: ProductItem(
//              productList[index].id,
//              productList[index].title, productList[index].imageUrl
          ),
        ));
  }
}
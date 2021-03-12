import 'package:flutter/material.dart';
import 'package:maxi_my_shop/providers/orders.dart';
import 'package:maxi_my_shop/providers/products.dart';
import 'package:maxi_my_shop/screens/cart_screen.dart';
import 'package:maxi_my_shop/screens/edit_product_screen.dart';
import 'package:maxi_my_shop/screens/orders_screens.dart';
import 'package:maxi_my_shop/screens/product_detail_screen.dart';
import 'package:maxi_my_shop/screens/products_overview_screen.dart';
import 'package:maxi_my_shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import "./providers/cart.dart";
import "./screens/cart_screen.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider.value(
        value:Products()),
      ChangeNotifierProvider.value(value: Cart()),
      ChangeNotifierProvider.value(value:Orders()),

    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor:Colors.deepOrange,
          fontFamily: "Lato"
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName:(context)=>ProductDetailScreen(),
          CartScreen.routName:(context)=>CartScreen(),
          OrdersScreen.routName:(context)=>OrdersScreen(),
          UserProductsScreen.routeName:(context)=>UserProductsScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),
        },
      ),
    );
  }
}

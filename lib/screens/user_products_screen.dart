import 'package:flutter/material.dart';
import 'package:maxi_my_shop/widgets/app_drawer.dart';
import"package:provider/provider.dart";
import "../providers/products.dart";
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';
class UserProductsScreen extends StatelessWidget {
  static const routeName="/UserProductsScreen";
 Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text("your Products "),
      actions: <Widget>[IconButton(icon:Icon(Icons.add),
        onPressed:()=>Navigator.of(context).pushNamed(EditProductScreen.routeName))],),
     drawer: AppDrawer(),
     body: RefreshIndicator(
       onRefresh: ()=>_refreshProducts(context),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView.builder(itemCount:productData.item.length,
           itemBuilder: (context,index) =>Column(children:[UserProductItem(id: productData.item[index].id,
             title: productData.item[index].title, imgUrl: productData.item[index].imageUrl,),Divider()]),),
       ),
     )
    );
  }
}






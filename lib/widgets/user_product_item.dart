import 'package:flutter/material.dart';
import 'package:maxi_my_shop/providers/products.dart';
import 'package:maxi_my_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final id ;
  final String title;
  final String imgUrl;

  UserProductItem({this.id,this.title, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl),),title: Text(title),
      trailing: Container(width:100,child: Row(children:<Widget>[
        IconButton(icon:Icon(Icons.add,color: Theme.of(context).primaryColor,),
            onPressed:()=>Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id)),
        IconButton(icon:Icon(Icons.delete,color:Theme.of(context).errorColor ,),onPressed: (() async{
          try {
            print("ffff");
         await Provider.of<Products>(context,listen: false).deleteProduct(id);

          }catch(error){
         scaffold.showSnackBar(SnackBar(content:Text("deleting faild!",textAlign: TextAlign.center,)));
          }
        }),)
      ])),
    );
  }
}

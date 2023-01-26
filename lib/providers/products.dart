import 'package:maxi_my_shop/models/http_exception.dart';
import 'package:maxi_my_shop/providers/product.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class Products with ChangeNotifier{
  List<Product> _items=[
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

  List<Product> get item{
    return [..._items];
  }
  Future<void> addItem(Product product)async{
    var url=Uri.parse("https://maixshopdeleteit-default-rtdb.firebaseio.com/products.json");
    try{
   final response=await http.post(url,body:json.encode({"title":product.title,
    "description":product.description,"imageUrl":product.imageUrl,"price":product.price,"isFavourite":product.isFavourite}));
   final newProduct=Product(title: product.title,description: product.description,
     price: product.price,imageUrl: product.imageUrl,id:json.decode(response.body)["id"],);
   _items.add(newProduct);
   notifyListeners();
  }catch(error){
    print (error);    throw error;
    }
  }
  Future<void> fetchAndSetProducts()async{
    final url=Uri.parse("https://maixshopdeleteit-default-rtdb.firebaseio.com/products.json");
    try{
      http.Response response=await http.get(url);
          final extractData=json.decode(response.body) as Map<String ,dynamic>;
      if(extractData==null){
        return ;
      }
          List<Product> loadedData=[];
         extractData.forEach((prodId, item) {loadedData.add(Product(id: prodId,title:item["title"],
             description:item["description"],imageUrl:item["imageUrl"],price:item["price"],isFavourite: item["isFavourite"]));
         _items=loadedData;
         notifyListeners();});

    }catch(error){
      print(error);
      //throw error;

    }
  }

  Future<void> deleteProduct(String id) async {
    Uri url=Uri.parse("https://maixshopdeleteit-default-rtdb.firebaseio.com/products/$id.json");
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
// Future<void>  deleteProduct(String id) async{
//   int indexWhere= _items.indexWhere((element) => element.id==id);
//   var productDelete=_items[indexWhere];
//   print ("ddd");
//   _items.removeAt(indexWhere);
//   notifyListeners();
//   Uri url=Uri.parse("https://maixshopdeleteit-default-rtdb.firebaseio.com/products/$id.json");
//   var response=await http.delete(url);
//   if(response.statusCode>=400){
//     _items.insert(indexWhere, productDelete);
//     notifyListeners();
//     print (response.statusCode);
//
//     throw HttpException("there is an error");
//
//   }
//   productDelete=null;
//  }
  Product findById(String id){
    return _items.firstWhere((prod)=>prod.id==id);
  }
  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Future<void> updateProduct(String id,Product newProduct)async{
    Uri url=Uri.parse("https://maixshopdeleteit-default-rtdb.firebaseio.com/products/$id.json");
   var itemIndex= _items.indexWhere(((prod)=>prod.id==id));
   if(itemIndex>=0){
     http.patch(url,body: json.encode({"title":newProduct.title,"price":newProduct.title,"description":newProduct
         .description,"imageUrl":newProduct.imageUrl}));
     _items[itemIndex]=newProduct;
     notifyListeners();
   }else{print("........");}


  }
}
//
//final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
//var existingProduct = _items[existingProductIndex];
//_items.removeAt(existingProductIndex);
//notifyListeners();
//final response = await http.delete(url);
//if (response.statusCode >= 400) {
//_items.insert(existingProductIndex, existingProduct);
//notifyListeners();
//throw HttpException('Could not delete product.');
//}
//existingProduct = null;
//}
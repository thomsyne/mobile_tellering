import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_tag.dart';

class Products extends StatelessWidget {

  Widget _buildProductList(List<Product>products){
    Widget productCards;
    products.length = 1;
    if (products.length > 0){
      productCards = ListView.builder (
        itemBuilder: (BuildContext context, int index) =>
          ProductCard(products[0]),
          itemCount: products.length,
        );
    } else{
      productCards =Container(child: Center(
            child: Text('No Products Found, please add some'),
          ),);
    }
    return productCards;
  }


  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return _buildProductList(model.displayedProducts);
    },); 
  }
}

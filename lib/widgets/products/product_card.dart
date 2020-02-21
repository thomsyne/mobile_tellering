import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  Widget _buildTitlePriceContainer() {
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AddressTag('E-mail Address: '),
            Text(product.userEmail),
            SizedBox(width: 18.0),
            
          ],
        ));
  }

  // Widget _buildRowButtonBar(BuildContext context) {
  //   return ScopedModelDescendant<MainModel>(
  //     builder: (BuildContext context, Widget child, MainModel model) {
  //       return Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               //padding: EdgeInsets.all(10.0),
  //               child: ButtonBar(
  //                 alignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   IconButton(
  //                       color: Theme.of(context).accentColor,
  //                       icon: Icon(Icons.info),
  //                       onPressed: () => Navigator.pushNamed<bool>(
  //                           context, '/product/' + model.allProducts[productIndex].id)),
  //                 ],
  //               ),
  //             ),
  //             IconButton(
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               color: Colors.red,
  //               icon: Icon(model.allProducts[productIndex].isFavorite
  //                   ? Icons.favorite
  //                   : Icons.favorite_border),
  //               onPressed: () {
  //                 model.selectProduct(model.allProducts[productIndex].id);
  //                 model.toggleProductFavoriteStatus();
  //               },
  //             ),
  //           ]);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(),
          FadeInImage(
            image: NetworkImage('https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
            height: 200.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('./assets/food.jpg'),

          ),
          _buildTitlePriceContainer(),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            AddressTag('User ID: '),
            Text(product.userId),
          ],),
          Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            AddressTag('Wallet Balance: '),
            Text('2000'),
          ],),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            AddressTag('Wallet Limit: '),
            Text('50,000'),
          ],),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            AddressTag('Total Amount COllected: '),
            Text('27,000'),
          ],),
          Divider(),
          
          AddressTag('99 Palm Avenue, Mushin, Lagos'),
          
//          _buildRowButtonBar(context)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductPage extends StatelessWidget {
final Product product;

ProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print('Back Button Pressed');
      Navigator.pop(context, false);
      return Future.value(false);
    }, 
    child:  Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/food.jpg'),
          ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Theme.of(context).accentColor,
                ),
                padding: EdgeInsets.all(3.0),
                child: Text( '\$' + product.price.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.2),
                    border: Border.all(color: Colors.orange, width: 2.0)),
                child: Text(product.description),
              )
            ],
          ),
        ));
    
  }
}

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/productadmin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped-models/main.dart';
import './models/product.dart';
import './pages/listpage.dart';
import './pages/profile.dart';
import './pages/fund_wallet.dart';

void main(){ 
  //debugPaintSizeEnabled = true;

  runApp(MyApp());
  }

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _MyAppState();
  }
}

class _MyAppState extends State <MyApp> {
 

  @override
  Widget build(BuildContext context) {
    final MainModel model =MainModel();
    //final Product product =Product(userId:'xx', id: 'xx', image: '', description: '',title: '', userEmail: 'test@test.com', price: 20  );
    return ScopedModel<MainModel>(
      model:model,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.blue,
            buttonColor: Colors.blue
            ,

            fontFamily: 'Oswald'
            ),
            
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage (),
          '/lp': (BuildContext context) => ListPage(model),
          '/pp': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductAdmin(model),
          '/pf': (BuildContext context) => ProfilePage(model),
          '/fw': (BuildContext context) => FundWallet(),
        },
        onGenerateRoute: (RouteSettings settings){
          final List <String> pathElements = settings.name.split('/');
          if (pathElements[0] != ''){
            return null;
          }

          if (pathElements[1] == 'product'){
            final String productId = pathElements[2];
            final Product product = model.allProducts.firstWhere((Product product){
              return product.id == productId;
            });
            return MaterialPageRoute<bool> (
                        builder: (BuildContext context) => ProductPage(product),
                          );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings){
          return MaterialPageRoute(builder:  (BuildContext context) => ProductsPage(model), );
        },
      ),) ;
  }
}

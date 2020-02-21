import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class ProfilePage extends StatefulWidget {
  final MainModel model;

  ProfilePage (this.model);
  
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
@override
initState(){
  widget.model.fetchProducts();
  super.initState();
}

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Admin Area'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Clients'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/lp');
            },
          ),
          ListTile(
            leading: Icon(Icons.move_to_inbox),
            title: Text('Register Clients'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: Text('User Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pf');
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Account Details'),
            onTap: () {
              //Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Fund Wallet'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/fw');
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('View Statement'),
            onTap: () {
              //Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Transaction History'),
            onTap: () {
              //Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

Widget _buildProductsList(){
  return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
    Widget content =Center(child:Text('No Products Found'));
    if (model.displayedProducts.length > 0 && !model.isLoading){
      content = Products();
    }else if(model.isLoading) {
      content = Center(child: CircularProgressIndicator(),);
    }
    return RefreshIndicator(
      onRefresh: model.fetchProducts,
      child: content,);
  },);
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('User Profile'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                color: Colors.white,
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildProductsList(),
    );
  }
}

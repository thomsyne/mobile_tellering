import 'package:flutter/material.dart';
import './product_list.dart';
import './product_edit.dart';
import '../scoped-models/main.dart';

class ProductAdmin extends StatelessWidget {
  final MainModel model;
 
  ProductAdmin(this.model);
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

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Admin Area'),
            bottom: TabBar(
              tabs: <Widget>[
                //Tab(text: 'Create Customer', icon: Icon(Icons.create)),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'Create Customer',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              //ProductEditPage(),
              ProductListPage(),
            ],
          )),
    );
  }
}

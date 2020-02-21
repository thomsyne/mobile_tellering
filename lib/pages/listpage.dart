import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-models/main.dart';

class ListPage extends StatefulWidget {
  final MainModel model;

  ListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  @override
  initState() {
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

  Widget _buildDeleteButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Are you Sure?'),
                content: Text('This action cannot be undone!'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('DELETE'),
                    onPressed: () {
                      Navigator.pop(context);

                      model.selectProduct(model.allProducts[index].id);
                      model.deleteProduct().then((_) {
                      model.selectProduct(null);
                      });
                    },
                  )
                ],
              );
            });
      },
    );
  }

  Widget _buildPaymentButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.payment),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return ProductEditPage();
          },
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text("Clients' List"),
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
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            print('Shows');
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: Key(model.allProducts[index].title),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      model.selectProduct(model.allProducts[index].id);
                      model.deleteProduct();
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(model.allProducts[index].image)),
                          title: Text(model.allProducts[index].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(model.allProducts[index].description),
                              Text(
                                  '\₦${model.allProducts[index].price.toString()}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _buildDeleteButton(context, index, model),
                              _buildPaymentButton(context, index, model)
                            ],
                          )),
                      Divider()
                    ],
                  ),
                );
              },
              itemCount: model.allProducts.length,
            );
          },
        ));
  }
}

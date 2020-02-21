import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class FundWallet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FundWalletPage();
  }
}

class _FundWalletPage extends State<FundWallet> {
  final Map<String, dynamic> _fundData = {
    'email': null,
    'amount': null,
    'location': null,
    'confirmDetails': false
  };

  final GlobalKey<FormState> _fundKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/bank.jpg'),
    );
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
              //Navigator.pushReplacementNamed(context, '/admin');
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


  Widget _buildEmailTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter your Email Address';
        }
      },
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
      onSaved: (String value) {
        _fundData['email'] = value;
      },
    );
  }

  Widget _buildAmountTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter Funding Amount';
        }
      },
      decoration: InputDecoration(
          labelText: 'Amount', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _fundData['amount'] = value;
      },
    );
  }

    Widget _buildLocationTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your Location';
        }
      },
      decoration: InputDecoration(
          labelText: 'Location', filled: true, fillColor: Colors.white),
      onSaved: (String value) {
        _fundData['location'] = value;
      },
    );
  }

  Widget _buildSwitchListTile() {
    return SwitchListTile(
      value: _fundData['confirmDetails'],
      onChanged: (bool value) {
        setState(() {
          _fundData['confirmDetails'] = value;
        });
      },
      title: Text('Confirm Details'),
    );
  }

  void _submitForm(Function login) {
    if (!_fundKey.currentState.validate() || !_fundData['confirmDetails']) {
      return;
    }
    _fundKey.currentState.save();
    login(_fundData['email'], _fundData['password'], _fundData['location']);
    Navigator.pushReplacementNamed(context, '/pf');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
       return DefaultTabController(
      length: 1,
      child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Fund Request'),
            // bottom: TabBar(
            //   tabs: <Widget>[
            //     //Tab(text: 'Create Customer', icon: Icon(Icons.create)),
            //     Tab(
            //       icon: Icon(Icons.list),
            //       text: 'Request Funds',
            //     ),
            //   ],
            // ),
          ),
          body:
              Container(
          child: SingleChildScrollView(
              child: Container(
            width: targetWidth,
            child: Form(
              key: _fundKey,
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(height: 10.0),
                  _buildAmountTextField(),
                  SizedBox(height: 10.0,),
                  _buildLocationTextField(),
                  _buildSwitchListTile(),
                  SizedBox(height: 10.0),
                  Center(
                    child: 
                      ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
                        return RaisedButton(
                      child: Text('Request Funds'),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/pf');
                      } //_submitForm(model.login),
                    );

                      },)
                    
                  ),
                ],
              ),
            ),
          )),
        ),
              
            ),
    );
  }
}

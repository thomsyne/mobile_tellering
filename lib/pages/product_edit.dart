import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _titleFocusNode,
        child: TextFormField(
          enabled: false,
          focusNode: _titleFocusNode,
          decoration: InputDecoration(labelText: 'Customer Name'),
          validator: (String value) {
            if (value.isEmpty || value.length < 5) {
              return 'Name is required and should be 5+ characters long';
            }
          },
        
          initialValue: product == null ? '' : product.title,
          onSaved: (String value) {
            _formData['title'] = value;
          },
        ));
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _descriptionFocusNode,
        child: TextFormField(
          enabled: false,
          focusNode: _descriptionFocusNode,
          validator: (String value) {
            if (value.isEmpty || value.length != 10) {
              return 'Account Number is required and should be 10 numbers long';
            }
          },
          initialValue: product == null ? '' : product.description,
          decoration: InputDecoration(labelText: 'Account Number'),
          keyboardType: TextInputType.number,
          onSaved: (String value) {
            _formData['description'] = value;
          },
        ));
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
        focusNode: _priceFocusNode,
        child: TextFormField(
          focusNode: _priceFocusNode,
          validator: (String value) {
            if (double.parse(value) < 1000 ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price must be greater than 1000 Naira';
            }
          },
          initialValue: product == null ? '' : '',
          decoration: InputDecoration(labelText: 'Amount Deposited'),
          keyboardType: TextInputType.number,
          onSaved: (String value) {
            _formData['price'] = double.parse(value) + product.price;
          },
        ));
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                textColor: Colors.white,
                child: Text('Make Payment'),
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

    Widget _buildReceiptButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // return model.isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
          return  RaisedButton(
                textColor: Colors.white,
                child: Text('Print Receipt'),
                onPressed: () {
                  //_submitForm(
                    //model.addProduct,
                    //model.updateProduct,
                    //model.selectProduct,
                    //model.selectedProductIndex),
                } 
              );
      },
    );
  }
  

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
                SizedBox(
                  height: 10.0,
                ),
                _buildSubmitButton(),
                _buildReceiptButton(),
                //GestureDetector(
                //onTap: _submitForm,
                //child: Container(
                //color: Colors.green,
                //padding: EdgeInsets.all(5.0),
                //child: Text('Button'),
                //))
              ],
            ),
          )),
    );
  }

  Widget _buildPageEditContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
                SizedBox(
                  height: 10.0,
                ),
                _buildSubmitButton(),
                _buildReceiptButton(),
                //GestureDetector(
                //onTap: _submitForm,
                //child: Container(
                //color: Colors.green,
                //padding: EdgeInsets.all(5.0),
                //child: Text('Button'),
                //))
              ],
            ),
          )),
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/lp')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/lp')
          .then((_) => setSelectedProduct(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =_buildPageContent(context, model.selectedProduct);
        final Widget pageEdit = _buildPageEditContent(context, model.selectedProduct);
        
        if (model.selectedProductIndex == -1){
          return Scaffold(body: pageContent,);
        }else{
          return WillPopScope(onWillPop: () {
      print('Back Button Pressed');
      Navigator.pop(context, false);
      return Future.value(false);
    },
    child: Scaffold(
                appBar: AppBar(
                  title: Text('Make a Payment'),
                ),
                body: pageEdit,
              ),
    );
        }
      },
    );
  }
}


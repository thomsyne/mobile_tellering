import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget{
  final String address;

  AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Text(address),
          );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        child: ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text(''),
        ),
      ),
    );
  }
}

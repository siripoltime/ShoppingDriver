// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: avoid_print, prefer_void_to_null, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';
import 'package:shoppingfood/provider/google_sign_in.dart';
import 'package:shoppingfood/states/authen.dart';
import 'package:shoppingfood/states/buyer_service.dart';
import 'package:shoppingfood/states/create_acccount.dart';
import 'package:shoppingfood/states/rider_service.dart';
import 'package:shoppingfood/states/saler_service.dart';
import 'package:shoppingfood/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/salerService': (BuildContext context) => SalerService(),
  '/riderService': (BuildContext context) => RiderService(),
};

String? initlaRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print(type);
  if (type?.isEmpty ?? true) {
    initlaRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlaRoute = MyConstant.routeBuyerService;
        runApp(MyApp());

        break;
      case 'seller':
        initlaRoute = MyConstant.routeSaleService;
        runApp(MyApp());

        break;
      case 'rider':
        initlaRoute = MyConstant.routeRiderService;
        runApp(MyApp());

        break;
      default:
    }
  }

  // runApp(MyApp());
  // initlaRoute = MyConstant.routeAuthen;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) => ChangeNotifierProvider(
  //     create: (context) => GoogleSignInprovider(),
  //     child: MaterialApp(
  //       title: MyConstant.appName,
  //       routes: map,
  //       initialRoute: initlaRoute,
  //     ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlaRoute,
    );
  }
}

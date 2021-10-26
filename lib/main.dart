// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
  initlaRoute = MyConstant.routeAuthen;
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

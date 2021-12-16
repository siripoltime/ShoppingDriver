// ignore_for_file: prefer_void_to_null, sized_box_for_whitespace, prefer_const_constructors, avoid_print, non_constant_identifier_names

// import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingfood/models/user_models.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
import 'package:shoppingfood/provider/google_sign_in.dart';
import 'package:shoppingfood/utility/my_constant.dart';
import 'package:shoppingfood/utility/my_dialog.dart';
import 'package:shoppingfood/widgete/show_images.dart';
import 'package:shoppingfood/widgete/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRed = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildImage(size),
                  buildAppName(),
                  buildUser(size),
                  buildPassword(size),
                  buildLogin(size),
                  // buildLoginGoogle(size),
                  buildCreateAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ? ',
          textStyle: MyConstant().h2Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: Text('Create Account'),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String user = userController.text;
                String password = passwordController.text;
                // print('$user , $password');
                checkAuthen(user, password);
              } else {}
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Future<Null> checkAuthen(String? user, String? password) async {
    String apicheckAuthen =
        'http://10.0.2.2:8012/shoppingfood/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apicheckAuthen).then((value) async {
      // print(value);
      if (value.toString() == 'null') {
        MyDialog()
            .normalDialog(context, 'User False', 'No $user in my Database');
      } else {
        for (var item in json.decode(value.data)) {
          UserModel userModel = UserModel.fromJson(item);
          if (password == userModel.password) {
            String? trpe = userModel.type;
            String? Users = userModel.user;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('type', trpe!);
            preferences.setString('user', Users!);

            switch (trpe) {
              case 'buyer':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeBuyerService, (route) => false);
                break;
              case 'seler':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeSaleService, (route) => false);
                break;
              case 'rider':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeRiderService, (route) => false);
                break;
              default:
            }
            // print(trpe);
          } else {
            MyDialog().normalDialog(
                context, 'Password False', 'No password in my Database');
          }
        }
      }
    });
  }

  // Row buildLoginGoogle(double size) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         margin: EdgeInsets.symmetric(vertical: 16),
  //         width: size * 0.6,
  //         child: ElevatedButton(
  //           style: MyConstant().myButtonStyle(),
  //           onPressed: () {
  //             // processSingGoogle();
  //             final provider =
  //                 Provider.of<GoogleSignInprovider>(context, listen: false);
  //             provider.googleLogin();
  //           },
  //           child: Text('google'),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please Fill User in Blank';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User :',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please Fill Password in Blank';
              } else {
                return null;
              }
            },
            obscureText: statusRed,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRed = !statusRed;
                  });
                },
                icon: statusRed
                    ? Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dart,
                      )
                    : Icon(
                        Icons.remove_red_eye,
                        color: MyConstant.dart,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password :',
              prefixIcon: Icon(
                Icons.lock_open_outlined,
                color: MyConstant.dart,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dart),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1Style(),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: ShowImage(path: MyConstant.image3),
        ),
      ],
    );
  }
}

// ignore_for_file: avoid_print, prefer_void_to_null, unnecessary_null_comparison, non_constant_identifier_names, prefer_const_constructors, unrelated_type_equality_checks, prefer_collection_literals

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingfood/utility/my_constant.dart';
import 'package:shoppingfood/utility/my_dialog.dart';
import 'package:shoppingfood/widgete/show_images.dart';
import 'package:shoppingfood/widgete/show_progress.dart';
import 'package:shoppingfood/widgete/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  String avatar = '';
  File? file;
  double? lat, lng;
  final foreKey = GlobalKey<FormState>();

  TextEditingController nameContrroller = TextEditingController();
  TextEditingController addressContrroller = TextEditingController();
  TextEditingController phoneContrroller = TextEditingController();
  TextEditingController userContrroller = TextEditingController();
  TextEditingController passwordContrroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkpermission();
  }

  Future<Null> checkpermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Location services are Open');
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาตแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find Latlong
          findlaglong();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาตแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find Latlong
          findlaglong();
        }
      }
    } else {
      print('Location services are disabled');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยครับ');
    }
  }

  Future<Null> findlaglong() async {
    print('findlaglong ==>work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat , lng = $lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: nameContrroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Name ด้วยครับ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Name :',
              prefixIcon: Icon(
                Icons.fingerprint,
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

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: phoneContrroller,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Phone ด้วยครับ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Phone :',
              prefixIcon: Icon(
                Icons.phone,
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

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userContrroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก User ด้วยครับ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User :',
              prefixIcon: Icon(
                Icons.perm_identity,
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
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordContrroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Password ด้วยครับ';
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password :',
              prefixIcon: Icon(
                Icons.lock_clock_outlined,
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: addressContrroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Address ด้วยครับ';
              }
            },
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: MyConstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dart,
                ),
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

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          biludCreateAccount(),
        ],
        title: Text('Create New'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: foreKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle('ข้อมูลทั่วไป : '),
                buildName(size),
                buildTitle('ชนิดของ User : '),
                buildRadioByer(size),
                buildRadioSeler(size),
                buildRadioRider(size),
                buildTitle('ข้อมูลพื้นฐาน'),
                buildAddress(size),
                buildPhone(size),
                buildUser(size),
                buildPassword(size),
                buildTitle('รูปภาพ'),
                buildsubTitle(),
                buileAvater(size),
                buildTitle('แสดงพิกัด'),
                buildMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton biludCreateAccount() {
    return IconButton(
      onPressed: () {
        if (foreKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose Type User');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือก Type User',
                'กรุณาเลือก ที่ Type User');
          } else {
            print('Process Insert to Datebase');
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> uploadPictureAndInsertData() async {
    String name = nameContrroller.text;
    String address = addressContrroller.text;
    String phone = phoneContrroller.text;
    String password = passwordContrroller.text;
    String user = userContrroller.text;
    print(
        'name : $name , addredd : $address , phone : $phone , password : $password, user : $user');
    String Uri =
        'http://10.0.2.2:8012/shoppingfood/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(Uri).then((value) async {
      if (value.toString() == 'null') {
        print('ok');

        if (file == null) {
          processInsertMySQL();
        } else {
          print('process Upload Avater');
          String apiSaveAvater =
              'http://10.0.2.2:8012/shoppingfood/saveFile.php';
          int i = Random().nextInt(100000);
          String nameAvater = 'avatar$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              await MultipartFile.fromFile(file!.path, filename: nameAvater);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveAvater, data: data).then((value) {
            avatar = '/shoppingfood/avater/$nameAvater';
            processInsertMySQL(
                name: name,
                address: address,
                phone: phone,
                user: user,
                password: password);
          });
        }
      } else {
        MyDialog().normalDialog(context, 'User False ?', 'Please Change User');
      }
    });
  }

  Future<Null> processInsertMySQL(
      {String? name,
      String? address,
      String? phone,
      String? user,
      String? password}) async {
    print('processInsertMySQL ===> $avatar');
    if (avatar == '') {
      MyDialog().normalDialog(context, 'avatar', 'กรุณาเลือกรูปภาพด้วย');
    } else {
      String apiInsertUser =
          'http://10.0.2.2:8012/shoppingfood/insertData.php?isAdd=true&name=$name&type=$typeUser&address=$address&phone=$phone&user=$user&password=$password&avater=$avatar&lat=$lat&lng=$lng';
      await Dio().post(apiInsertUser).then((value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          MyDialog().normalDialog(
              context, 'Create New User False !!!', 'Plase Try Again');
        }
      });
    }
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat,Lng = $lng'),
        )
      ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 300,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(result!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Row buileAvater(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(Icons.add_a_photo),
          color: MyConstant.dart,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.5,
          child: file == null
              ? ShowImage(path: MyConstant.avater)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(Icons.add_photo_alternate),
          color: MyConstant.dart,
        ),
      ],
    );
  }

  ShowTitle buildsubTitle() {
    return ShowTitle(
      title: 'เป็นรูปภาพ',
      textStyle: MyConstant().h3Style(),
    );
  }

  Row buildRadioByer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value.toString();
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ (Buyer)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeler(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seler',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย (Seler)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ส่ง (Rider)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/view/login_page.dart';
import 'package:project/model/data_model.dart';
import 'package:project/view/dashboard.dart';
import 'package:project/view/homepage.dart';
import 'helper/shared_preferences.dart';
import 'dart:ui';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initiateLocalDB();
  SharedPreference().getLoginStatus().then((status) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: status ? Dashboard() : HomePage()));
  });
  //runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  await Hive.openBox<DataModel>("data");
}

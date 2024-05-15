import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todoapp/Views/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
//initialize
  await Hive.initFlutter();

  //open the box
 var box = await Hive.openBox('MyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

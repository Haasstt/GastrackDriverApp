// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:flutter/material.dart';
import 'package:gastrack_driver/page/homepage.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:flutter_easyloading/src/easy_loading.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

//page
import 'page/coverpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(GetMaterialApp(
    theme: customTheme,
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    routes: <String, WidgetBuilder>{
      '/main': (BuildContext context) => const MyApp(),
      '/cover': (BuildContext context) => const Coverpage(),
      '/home': (BuildContext context) => const Homepage()
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      // EasyLoading.show();
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: (SpUtil.getBool('kurir', defValue: false)!
              ? const Homepage()
              : const Coverpage()),
          type: PageTransitionType.fade,
        ),
      );

      // EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(249, 1, 131, 1.0),
              Color.fromRGBO(128, 38, 198, 1.0)
            ], // Warna gradient
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icon/logo_white.png",
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}

final ThemeData customTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(249, 1, 131, 1.0),
    ),
  ),
);

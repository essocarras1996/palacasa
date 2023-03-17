import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palacasa/PaLaCasaAppHomeScreen.dart';

import 'Login&Register/Login.dart';
import 'Login&Register/OnBoardingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,//color bottomBar
      systemNavigationBarDividerColor: Colors.white,// color de dividir bottomBar de screen es una linea
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoardingPage()//Login(),//PaLaCasaAppHomeScreen(),
    );
  }
}

import 'package:bookmanager/src/presentation/home/home_page.dart';
import 'package:bookmanager/src/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  // const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Book Manager",
      theme: ThemeData(
        primaryColor: Color(0xffF7C01B),
      ),
      home: HomePage(),
      // home: LoginPage(),
    );
  }
}

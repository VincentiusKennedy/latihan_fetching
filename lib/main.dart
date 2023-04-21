import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latihan_post/API/auth_repo.dart';
import 'package:latihan_post/screen/homePage.dart';
import 'package:latihan_post/screen/loginPage.dart';
import 'package:latihan_post/screen/registerPage.dart';
import 'package:latihan_post/screen/todoAdd.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  Widget? initialScreen;

  String url =
      Platform.isAndroid ? 'http://192.168.1.2:3000' : 'http://localhost:3000';
  if (token != null) {
    try {
      Map<String, dynamic> userData =
          await checkToken(token, url); // tambahkan argumen url
      if (userData.isNotEmpty) {
        initialScreen = Homepage(userData: userData);
        print(userData);
      } else {
        initialScreen = LoginPage();
        await prefs.remove('token');
      }
    } catch (e) {
      print(e);
      initialScreen = LoginPage();
      await prefs.remove('token');
    }
  } else {
    initialScreen = LoginPage();
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Widget initialScreen;

  MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => initialScreen,
        '/addTodo': (context) => const todoAdd(),
        '/login': (context) => LoginPage(),
        '/homePage': (context) => Homepage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

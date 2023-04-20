import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_post/screen/homePage.dart';
import 'package:latihan_post/screen/loginPage.dart';
import 'package:latihan_post/screen/registerPage.dart';
import 'package:latihan_post/screen/todoAdd.dart';
import 'package:latihan_post/screen/todoList.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget initialScreen = LoginPage();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    Map<String, dynamic> userData = await checkToken(token);
    if (userData.isNotEmpty) {
      initialScreen = Homepage(userData: userData);
      print(userData); // <-- mengirimkan parameter userData
    } else {
      initialScreen = LoginPage();
      await prefs.remove('token');
    }
  }

  runApp(MyApp(initialScreen: initialScreen));
}

Future<Map<String, dynamic>> checkToken(String token) async {
  String url =
      Platform.isAndroid ? 'http://192.168.1.2:3000' : 'http://localhost:3000';

  final response = await http
      .get(Uri.parse('$url/me'), headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final userData = json.decode(response.body)['data']['user'];
    return userData;
  } else {
    return {};
  }
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

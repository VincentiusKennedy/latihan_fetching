import 'package:flutter/material.dart';
import 'package:latihan_post/model/model.dart';
import 'package:latihan_post/API/repository.dart';
import 'package:latihan_post/screen/todoAdd.dart';
import 'package:latihan_post/screen/todoList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'My Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Flutter App'),
          actions: [
            IconButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/addTodo');
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: todoList(),
      ),
      routes: {
        '/addTodo': (context) => todoAdd(),
      },
    );
  }
}

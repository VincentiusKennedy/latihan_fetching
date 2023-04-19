import 'package:flutter/material.dart';
import 'package:latihan_post/screen/account.dart';
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
          title: const Text('My Flutter App'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.maybeOf(context)?.openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Akun'),
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/accountDetail');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Pengaturan'),
                onTap: () {
                  // navigasi ke halaman pengaturan
                },
              ),
            ],
          ),
        ),
        body: todoList(),
      ),
      routes: {
        '/addTodo': (context) => const todoAdd(),
        '/accountDetail': (context) => const AccountDetail(
              profileImage:
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
              name: 'Nama Pengguna',
              dateOfBirth: '01 Januari 2000',
            ),
      },
    );
  }
}

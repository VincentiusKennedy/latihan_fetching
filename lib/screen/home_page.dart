import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latihan_post/API/auth_repo.dart';
import 'package:latihan_post/screen/account.dart';
import 'package:latihan_post/screen/loginPage.dart';
import 'package:latihan_post/screen/todoList.dart';
import 'package:shared_preferences/shared_preferences.dart';

getPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

class Homepage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String url =
      Platform.isAndroid ? 'http://192.168.1.6:3000' : 'http://localhost:3000';

  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userData = checkToken(getPref().getString('token'), url); //
    return Scaffold(
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
                if (userData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountDetail(
                        profileImage:
                            'https://picsum.photos/seed/picsum/200/300',
                        name: userData!['name'],
                        email: userData!['email'],
                        userData: userData,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('User data tidak lengkap atau kosong')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                if (userData != null) {
                  print('Name: ${userData!['name']}');
                  print('Desc: ${userData!['desc']}');
                  print(userData);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('User data tidak lengkap atau kosong')),
                  );
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: todoList(),
    );
  }
}

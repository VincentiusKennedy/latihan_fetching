import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan_post/model/model.dart';

class Repository {
  final _baseUrl = 'https://6430fd953adb159651639c30.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Todo> todo = it.map((e) => Todo.fromJson(e)).toList();
        return todo;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String title, String description) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/list'), body: {
        'title': title,
        'description': description,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:latihan_post/model/me_model.dart';

class ApiService {
  final String _baseUrl =
      Platform.isAndroid ? 'http://192.168.1.6:3000' : 'http://localhost:3000';
  static const String _urlGetUser = "/me";

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final token = data['token'];
      print(token);
      return token;
    } else {
      final errorBody = json.decode(response.body);
      final errorMessage = errorBody["message"];
      throw Exception(errorMessage ?? "Failed to login");
    }
  }

  Future<User> getUserData(String token) async {
    final response =
        await http.get(Uri.parse('$_baseUrl$_urlGetUser'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'];
      final user = User.fromJson(responseData['user']);
      print(user.desc);
      return user;
    } else {
      throw Exception("Failed to get user data");
    }
  }
}

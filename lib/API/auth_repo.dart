import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String apiUrl;

  AuthRepository({required this.apiUrl});

  Future<String> signIn(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$apiUrl/signin'),
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

      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Check token validity
      String url = Platform.isAndroid
          ? 'http://192.168.1.2:3000'
          : 'http://localhost:3000';
      final userData = await checkToken(token, url);

      return token;
    } else {
      final message = jsonDecode(response.body)['message'];
      throw Exception(message);
    }
  }
}

Future<Map<String, dynamic>> checkToken(String token, String url) async {
  final response = await http
      .get(Uri.parse('$url/me'), headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    final userData = json.decode(response.body)['data']['user'];
    return userData;
  } else {
    return {};
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationResponse {
  final Map<String, dynamic> user;
  final String token;

  RegistrationResponse(this.user, this.token);
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<RegistrationResponse> _register({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final url = Uri.parse('http://localhost:3000/register');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _nameController.text,
        'email': _emailController.text,
        'picture': _pictureController.text,
        'desc': _descController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final user = responseData['data']['user'];
      final token = responseData['data']['token'];
      onSuccess();
      return RegistrationResponse(user, token);
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] as String;
      onError(errorMessage);
      throw Exception(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email address',
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _pictureController,
              decoration: const InputDecoration(
                hintText: 'Enter your profile picture link',
                labelText: 'Profile Picture',
              ),
            ),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                hintText: 'Enter your description',
                labelText: 'Description',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _register(
                  onSuccess: () {
                    Navigator.of(context).pop();
                  },
                  onError: (errorMessage) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

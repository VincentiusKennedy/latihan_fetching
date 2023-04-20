import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AccountDetail extends StatefulWidget {
  final String profileImage;
  final String name;
  final String dateOfBirth;

  const AccountDetail({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.dateOfBirth,
  }) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      var headers = {
        'Authorization': 'Bearer 70fb83282fffd7d41732cf66c682bb75be896638',
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.imgur.com/3/image'));
      request.headers.addAll(headers);
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.statusCode);
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Akun'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : NetworkImage(widget.profileImage)
                          as ImageProvider<Object>?,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tanggal Lahir: ${widget.dateOfBirth}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: uploadImage,
                child: const Text('Simpan Gambar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

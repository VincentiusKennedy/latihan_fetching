import 'package:flutter/material.dart';
import 'package:latihan_post/API/repository.dart';

class todoAdd extends StatefulWidget {
  const todoAdd({Key? key}) : super(key: key);

  static const String routeName = '/addTodo';

  @override
  State<todoAdd> createState() => _todoAddState();
}

class _todoAddState extends State<todoAdd> {
  Repository repository = Repository();
  final _titleConotroller = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _titleConotroller,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.postData(
                  _titleConotroller.text,
                  _descriptionController.text,
                );

                if (response) {
                  Navigator.of(context).pop();
                } else {
                  print('Post data gagal');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

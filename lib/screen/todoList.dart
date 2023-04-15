import 'package:flutter/material.dart';
import 'package:latihan_post/model/model.dart';
import 'package:latihan_post/API/repository.dart';
import 'package:latihan_post/screen/todoAdd.dart';

class todoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<todoList> {
  List<Todo> _listTodo = [];

  Repository _repository = Repository();

  void _getData() async {
    _listTodo = await _repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listTodo.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listTodo.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = _listTodo[index];
                return Card(
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    leading: CircleAvatar(
                      child: Text(todo.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, todoAdd.routeName);
          _getData();
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

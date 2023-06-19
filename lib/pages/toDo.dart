import 'package:commerce_flutter/model/toDoModel.dart';
import 'package:commerce_flutter/service/toDoService.dart';
import 'package:flutter/material.dart';

import '../model/userModel.dart';

class ToDoPage extends StatefulWidget {
  final User user;
  ToDoPage({required this.user});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  ToDoService toDoService = ToDoService();
  List<Todo> todos = [];
  late int id;
  late User user;

  @override
  void initState() {
    super.initState();

    setState(() {
      user = widget.user;
      id = user.id;
    });
    toDoService.getToDoByUserid(id).then((value) {
      setState(() {
        if (value != null) {
          todos = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todos[index];

          return ListTile(
            onTap: () {
              setState(() {
                // Toggle the checkbox state
                todo.completed = !todo.completed;
              });
            },
            title: Text(todo.todo),
            leading: CheckboxWidget(
              value: todo.completed,
            ),
          );
        },
      ),
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  final bool value;

  CheckboxWidget({required this.value});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? newValue) {
        setState(() {
          isChecked = newValue ?? false;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(
        color: isChecked ? Colors.green : Colors.grey,
        width: 2.0,
      ),
      activeColor: Colors.green,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/toDoModel.dart';

class ToDoService {
  Dio dio = Dio();
  Future<List<Todo>?> getToDos() async {
    String url = "$api/todos";

    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = toDoModelFromJson(response.data!);
        return data.todos;
      }
    } catch (e) {
      debugPrint("error from  get todos is - $e");
    }
    return null;
  }

  Future<Todo?> getToDoOne(int query) async {
    String url = "$api/todos/$query";

    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = Todo.fromJson(response.data);
        return data;
      }
    } catch (e) {
      debugPrint("error from  get todo one is - $e");
    }
    return null;
  }

  Future<Todo?> getToDoRandom() async {
    String url = "$api/todos/random";

    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = Todo.fromJson(response.data);
        return data;
      }
    } catch (e) {
      debugPrint("error from  get todo random is - $e");
    }
    return null;
  }

  Future<List<Todo>?> getToDoLimit(int limit, int skip) async {
    String url = "$api/todos?limit=$limit&skip=$skip";

    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = toDoModelFromJson(response.data!);
        return data.todos;
      }
    } catch (e) {
      debugPrint("error from  get todos is - $e");
    }
    return null;
  }

  Future<List<Todo>?> getToDoByUserid(int id) async {
    String url = "$api/todos/user/$id";

    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = toDoModelFromJson(response.data!);
        return data.todos;
      }
    } catch (e) {
      debugPrint("error from  get todos is - $e");
    }
    return null;
  }

  Future<void> addToDo(Todo todo) async {
    String url = "$api/todos/add";
    var request = await dio.post(url, data: todo.toJson());
    try {
      if (request.statusCode == 201) {
        debugPrint("everthink is okay from addTodo");
      }
    } catch (e) {
      debugPrint("error from addTodo is - $e");
    }
  }

  Future<Todo?> putProduct({required Todo todo, required String id}) async {
    Todo? updatedTodo;

    try {
      Response response = await dio.put(
        api + '/todos/$id',
        data: todo.toJson(),
      );

      debugPrint('Todo updated: ${response.data}');

      updatedTodo = Todo.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating todo is : $e');
    }

    return updatedTodo;
  }

  Future<void> deleteTodo(int id) async {
    String url = "$api/todos/$id";
    try {
      var response = await dio.delete(url);
      if (response.statusCode == 200) {
        debugPrint("todo is deleted");
      }
    } catch (e) {
      print("Error is from delete Todo -  $e");
    }
  }
}

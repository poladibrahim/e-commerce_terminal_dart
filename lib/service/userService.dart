import 'package:commerce_flutter/model/postModel.dart';
import 'package:commerce_flutter/model/toDoModel.dart';
import 'package:commerce_flutter/model/userModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/cartModel.dart';

class UserService {
  final String url = "$api/users";
  final Dio dio = Dio();

  Future<List<User>?> getUsers() async {
    try {
      final response = await dio.get<String>(url);
      if (response.statusCode == 200) {
        final userModel = userModelFromJson(response.data!);
        debugPrint("Users loaded successfully");
        return userModel.users;
      } else {
        debugPrint("Failed to load users");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null; // Return null in case of error
  }

  // /users/1
  Future<User?> getOneUsers(int id) async {
    final String url = "$api/users/$id";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data!);
        debugPrint("Users loaded successfully");
        return user;
      } else {
        debugPrint("Failed to load users");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  // /users/search?q=John
  Future<List<User>?> searchUser(String name) async {
    final String url = "$api/users/search?q=$name";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data!);
        debugPrint("Users loaded successfully");
        return userModel.users;
      } else {
        debugPrint("Failed to load users");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null; // Return null in case of error
  }

  // /users/filter?key=hair.color&value=Brown
  Future<List<User>?> filterhUser(String key, String value) async {
    final String url = "$api/users/filter?key=$key&value=$value";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data!);
        debugPrint("Users loaded successfully");
        return userModel.users;
      } else {
        debugPrint("Failed to load users");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null; // Return null in case of error
  }

  Future<List<User>?> limitUser(int limit, int skip) async {
    final String url = "$api/users?limit=$limit&skip=$skip";
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(response.data!);
        debugPrint("Users loaded successfully");
        return userModel.users;
      } else {
        debugPrint("Failed to load users");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null; // Return null in case of error
  }

  Future<List<Product>?> getUserCartsByid(int id) async {
    String url = "$api/users/$id/carts";
    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = cartModelFromJson(response.data!);
        CartModel cartModel = data; // Update this line

        List<Product> products = [];
        List<Cart> cartsList = [];

        final List<Cart> cartProducts = cartModel.carts;
        cartsList.addAll(cartProducts);

        for (final product in cartsList) {
          final List<Product> prod = product.products;
          products.addAll(prod);
        }
        return products;
      }
    } catch (e) {
      debugPrint("error from get user cart is - $e");
    }
    return null;
  }

  Future<List<Post>?> getUserPosts(int id) async {
    String url = "$api/users/$id/posts";
    var response = await dio.get<String>(url);

    if (response.statusCode == 200) {
      var dat = postModelFromJson(response.data!);

      debugPrint("data yuklendi");
      return dat.posts;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<Todo>?> getToDos(int id) async {
    String url = "$api/users/$id/todos";

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

  Future<void> postUser(User user) async {
    String url = "$api/users/add";

    var request = await dio.get(url, data: user);

    if (request.statusCode == 201) {
      debugPrint("everything is okay");
    } else {
      debugPrint("post fail oldi");
    }
  }

  Future<User?> patchProduct({required User user, required String id}) async {
    User? updatedUser;

    try {
      final dio = Dio();

      final response = await dio.patch(
        '$api/products/$id',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        updatedUser = User.fromJson(response.data);
      } else {
        debugPrint('Error updating product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating product: $e');
    }

    return updatedUser;
  }

  Future<void> deleteUser(int id) async {
    String url = "$api/users/$id";
    try {
      await dio.delete(url);
    } catch (e) {
      print("Error is $e");
    }
  }
  // /users/5/carts

  // /users?limit=5&skip=10&select=firstName
}

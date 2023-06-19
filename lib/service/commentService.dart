import 'package:commerce_flutter/model/commentModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CommenetService {
  Dio dio = Dio();

  Future<List<Comment>?> getComments() async {
    String url = "$api/commnets";
    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = commentModelFromJson(response.data);
        return data.comments;
      }
    } catch (e) {
      debugPrint("error is - $e");
    }
    return null;
  }

// /comments?limit=10&skip=10&select=body,postId
  Future<Comment?> getOneComments(int id) async {
    String url = "$api/commnets/$id";
    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = Comment.fromJson(response.data);
        return data;
      }
    } catch (e) {
      debugPrint("error is - $e");
    }
    return null;
  }

  Future<List<Comment>?> getCommentsByPostid(int id) async {
    String url = "$api/comments/post/$id";
    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = commentModelFromJson(response.data!);
        return data.comments;
      }
    } catch (e) {
      debugPrint("comment error is - $e");
    }
    return null;
  }

  Future<List<Comment>?> getLimitComments(int limit, int skip) async {
    String url = "$api/comments?limit=$limit&skip=$skip";
    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = commentModelFromJson(response.data);
        return data.comments;
      }
    } catch (e) {
      debugPrint("error is - $e");
    }
    return null;
  }

  Future<dynamic> addCart(Comment comment) async {
    String url = "$api/carts/add";
    try {
      var request = await dio.post(url, data: comment);
      if (request.statusCode == 201) {
        debugPrint("everythink is okay in add comment");
      }
      return request.data;
    } catch (e) {
      debugPrint("error from add commment is - $e");
    }
  }

  Future<void> deleteComment(int id) async {
    String url = "$api/comments/$id";
    try {
      await dio.delete(url);
    } catch (e) {
      print("Error is $e");
    }
  }

  Future<Comment?> putComment({required Comment comment, required String id}) async {
    Comment? updatedComment;

    try {
      Response response = await dio.put(
        api + '/carts/$id',
        data: comment.toJson(),
      );

      debugPrint('Comment updated: ${response.data}');

      updatedComment = Comment.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating Comment: $e');
    }

    return updatedComment;
  }
}

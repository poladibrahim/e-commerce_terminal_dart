import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/postModel.dart';

class PostService {
  String url = "$api/posts";
  Dio dio = Dio();
  Future<List<Post>?> getPosts() async {
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

  Future<Post?> getPostOne(var id) async {
    String url = "$api/posts/$id";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      debugPrint("data yuklendi");
      return Post.fromJson(response.data);
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<Post>?> searchPosts(String query) async {
    String url = "$api/posts/search?q=$query";
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

  Future<List<Post>?> searchPostsById(int query) async {
    String url = "$api/posts/user/$query";
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

  Future<List<Post>?> getPostComments(int query) async {
    String url = "$api/posts/$query/comments";
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

  Future<void> postPost(Post post) async {
    String url = "$api/posts/add";
    var request = await dio.get(url, data: post);

    if (request.statusCode == 201) {
      debugPrint("everything is okay");
    } else {
      debugPrint("post fail oldi");
    }
  }

  Future<Post?> putPost({required Post post, required String id}) async {
    Post? updatedPost;

    try {
      Response response = await dio.put(
        api + '/posts/$id',
        data: post.toJson(),
      );

      debugPrint('Product updated: ${response.data}');

      updatedPost = Post.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating user: $e');
    }

    return updatedPost;
  }

  Future<void> deletePost(int id) async {
    String url = "$api/posts/$id";
    try {
      await dio.delete(url);
    } catch (e) {
      print("Error is $e");
    }
  }
}

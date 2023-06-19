import 'package:commerce_flutter/model/postModel.dart';
import 'package:commerce_flutter/service/commentService.dart';
import 'package:commerce_flutter/service/postService.dart';
import 'package:flutter/material.dart';

import '../model/commentModel.dart';

class SinglePostPage extends StatefulWidget {
  final index;
  const SinglePostPage({super.key, this.index});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  bool isLoading = true;
  PostService postService = PostService();
  Post? post;
  bool showComments = false;
  List<Comment> comments = [];
  CommenetService commenetService = CommenetService();
  @override
  void initState() {
    super.initState();
    postService.getPostOne(widget.index).then((value) {
      setState(() {
        if (value != null) {
          post = value;
          isLoading = false;
        }
      });
    });
    commenetService.getCommentsByPostid(widget.index).then((value) {
      setState(() {
        if (value != null) {
          comments = value;
        }
      });
    });
  }

  void setShow() {
    setState(() {
      showComments = !showComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Post"),
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            if (post != null)
              Column(
                children: [
                  Text(
                    "Title : ${post!.title}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Details - ${post!.body}",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setShow();
                  },
                  child: Text('Comments'),
                )
              ],
            ),
            if (showComments && comments.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: Text(
                        "User id - ${comments[index].postId} ",
                        style: const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("${comments[index].body}"),
                    );
                  },
                ),
              ),
            if (showComments && comments.isEmpty)
              Text(
                "No comments found.",
                style: TextStyle(fontSize: 15),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:commerce_flutter/model/postModel.dart';
import 'package:commerce_flutter/pages/singlePost.dart';
import 'package:commerce_flutter/service/postService.dart';
import 'package:flutter/material.dart';

import '../model/userModel.dart';

class MyPostPage extends StatefulWidget {
  final User user;

  MyPostPage({required this.user});

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  late User user;
  List<Post> posts = [];
  PostService postService = PostService();
  Post? product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user = widget.user;
    });
    debugPrint("hello from init");
    postService.getPosts().then((value) {
      setState(() {
        if (value != null) {
          debugPrint("hello from value");
          posts = value;
          debugPrint("hello from value");
        }
      });
    });
    postService.searchPostsById(user.id).then((value) {
      setState(() {
        if (value != null) {
          posts = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostPage"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => SearchPostPage(),
        //           ));
        //     },
        //   ),
        // ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns here
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SinglePostPage(
                    index: index,
                  ),
                ),
              );
            },
            child: GridTile(
              child: Container(
                color: Colors.amber,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text("From user id - ${posts[index].userId}"),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      posts[index].title,
                      style: const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Positioned(
                      left: 8,
                      bottom: 3.5,
                      child: Text(
                        "${posts[index].reactions}",
                        style: TextStyle(fontSize: 21),
                      )),
                  Positioned(left: 20, bottom: 5, child: Icon(Icons.favorite)),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Text(
                      posts[index].tags[0],
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:commerce_flutter/model/postModel.dart';
import 'package:commerce_flutter/service/postService.dart';
import 'package:flutter/material.dart';

class SearchPostPage extends StatefulWidget {
  const SearchPostPage({super.key});

  @override
  State<SearchPostPage> createState() => _SearchPostPageState();
}

class _SearchPostPageState extends State<SearchPostPage> {
  PostService postService = PostService();
  String enteredTitle = "";
  int enteredId = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  List<Post> posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search posts"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: titleController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        enteredTitle = value;
                        postService.searchPosts(enteredTitle).then((value) {
                          posts = value!;
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(hintText: "by title"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: idController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        enteredId = int.parse(value);
                        postService.searchPostsById(enteredId).then((value) {
                          posts = value!;
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(hintText: "by id"),
                ),
              )
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of columns here
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: Container(
                    color: Color.fromARGB(255, 94, 185, 207),
                    child: Text(
                      posts[index].title,
                      style: const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

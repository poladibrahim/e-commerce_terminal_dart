import 'package:commerce_flutter/pages/myPost.dart';
import 'package:commerce_flutter/pages/postPage.dart';
import 'package:commerce_flutter/pages/quote.dart';
import 'package:commerce_flutter/pages/toDo.dart';
import 'package:flutter/material.dart';

import '../model/userModel.dart';
import '../pages/login.dart';

class CustomDrawer extends StatefulWidget {
  final User user;
  CustomDrawer({required this.user});
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("${user.image}"),
                ),
                SizedBox(height: 10),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('To do'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoPage(user: user),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Posts'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('My Posts'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPostPage(user: user),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Quotes'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuotePage(
                      user: user,
                    ),
                  ));
            },
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

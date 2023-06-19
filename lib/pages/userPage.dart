import 'package:commerce_flutter/model/userModel.dart';
import 'package:commerce_flutter/service/userService.dart';
import 'package:commerce_flutter/widget/customDrawer.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  late User? user;
  UserPage({required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isExpanded = false;
  late User user;
  UserService userService = UserService();
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    user = widget.user!;
    userService.getUsers().then((value) {
      setState(() {
        if (value != null) {
          users = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Information")),
      drawer: CustomDrawer(user: user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: isExpanded ? MediaQuery.of(context).size.height : 200,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Hero(
                    tag: 'user_image',
                    child: Image.network(
                      user.image,
                      fit: isExpanded ? BoxFit.fitWidth : BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Username: ${user.username}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${user.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: ${user.phone}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Personal Details',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'Age: ${user.age}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Gender: ${user.userAgent}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Birth Date: ${user.birthDate}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Blood Group: ${user.bloodGroup}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Height: ${user.height} cm',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Weight: ${user.weight} kg',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

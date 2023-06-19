import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/ProductModel.dart';
import '../service/productService.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController searchController = TextEditingController();
  List<Product> productsList = [];
  String enteredSearch = "";
  List<String> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productService.getCategories().then((value) {
        categories = value!;
      });
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController imagesController = TextEditingController();
  ProductService productService = ProductService();
  Product? product;
  late String enteredName;
  late int enteredPrice;
  late double enteredStock;
  late List<String> enteredImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Enter the name of the product:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "name"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter the price of the product:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: "name"),
            ),
            const Text(
              "Enter the stock of the product:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(hintText: "name"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter the images of the product:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: imagesController,
              decoration: InputDecoration(hintText: "name"),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    enteredName = nameController.text;
                    enteredPrice = int.parse(priceController.text);
                    enteredStock = double.tryParse(stockController.text)!;
                    enteredImages = stockController.text.split(",");
                    debugPrint(enteredName + " " + "$enteredPrice");
                  }
                },
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Sign Up")
                ]),
              ),
            ),
            SizedBox(
              child: Text(categories[1]),
            )
          ],
        ),
      ),
    );
  }
}

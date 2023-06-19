import 'package:commerce_flutter/pages/addProduct.dart';
import 'package:commerce_flutter/pages/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/ProductModel.dart';
import '../service/productService.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isLoading = true;
  List<Product> products = [];
  ProductService productService = ProductService();
  Product? product;
  int selectedButtonIndex = 0; // Track the index of the selected button

  @override
  void initState() {
    super.initState();
    loadData(0);
    try {
      productService.getProductOne(1).then((value) {
        setState(() {
          if (value != null) {
            product = value;
            isLoading = false;
          }
        });
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
    }
  }

  loadData(int skip) {
    productService.getProductsLimit(skip).then((value) {
      setState(() {
        if (value != null) {
          products = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleProductPage(
                            index: index + 1,
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                      products[index].images[0],
                      cacheHeight: 50,
                      cacheWidth: 70,
                    ),
                    trailing: Text(
                      "${products[index].price} \$",
                      style: const TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("${products[index].title}"),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    loadData(0);
                    setState(() {
                      selectedButtonIndex = 0; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 0 ? Colors.black : null,
                  ),
                  child: const Text('1'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(25);
                    setState(() {
                      selectedButtonIndex = 1; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 1 ? Colors.black : null,
                  ),
                  child: const Text('2'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(50);
                    setState(() {
                      selectedButtonIndex = 2; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 2 ? Colors.black : null,
                  ),
                  child: const Text('3'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(75);
                    setState(() {
                      selectedButtonIndex = 3; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 3 ? Colors.black : null,
                  ),
                  child: const Text('4'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

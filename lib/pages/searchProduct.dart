import 'package:commerce_flutter/model/ProductModel.dart';
import 'package:commerce_flutter/pages/singleProduct.dart';
import 'package:commerce_flutter/service/productService.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  ProductService productService = ProductService();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
            onChanged: (value) {
              setState(() {
                enteredSearch = value;
                productService.searchProducts(enteredSearch).then((value) {
                  productsList = value!;
                });
              });
            },
            decoration: InputDecoration(hintText: "Search here")),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: categories.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return ListTile(title: Text("Brand Name is ${categories[index]}"));
          //       }),
          // ),
          Expanded(
            child: ListView.builder(
                itemCount: productsList.length,
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
                        productsList[index].images[0],
                        cacheHeight: 50,
                        cacheWidth: 70,
                      ),
                      trailing: Text(
                        "${productsList[index].price} \$",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      title: Text(" ${productsList[index].title}"));
                }),
          ),
        ],
      ),
    );
  }
}

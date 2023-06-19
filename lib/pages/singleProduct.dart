import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../model/ProductModel.dart';
import '../service/productService.dart';

class SingleProductPage extends StatefulWidget {
  final index;
  SingleProductPage({Key? key, this.index}) : super(key: key);

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  bool isloading = true;
  ProductService productService = ProductService();
  Product? product;
  @override
  void initState() {
    super.initState();
    productService.getProductOne(widget.index).then((value) {
      setState(() {
        if (value != null) {
          product = value;
          isloading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: !isloading,
        replacement: Center(child: CircularProgressIndicator()),
        child: SafeArea(
          child: Column(
            children: [
              if (product != null)
                Text(
                  "${product!.brand}",
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              if (product != null)
                CarouselSlider.builder(
                  itemCount: product?.images.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                    child: Image.network(product!.images[itemIndex]),
                  ),
                  options: CarouselOptions(),
                ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (product != null) Text("Price - ${product!.price}\$"),
                  if (product != null) Text("Discount - ${product!.discountPercentage}%"),
                  if (product != null) Text("Stock - ${product!.stock}"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("${product?.description ?? ''}"),
              SizedBox(
                height: 5,
              ),
              Text(product?.thumbnail ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

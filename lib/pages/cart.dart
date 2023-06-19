import 'package:commerce_flutter/service/cartService.dart';
import 'package:flutter/material.dart';

import '../model/cartModel.dart';
import '../model/userModel.dart';

class CartPage extends StatefulWidget {
  final User user;
  CartPage({required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<AssetImage> imageList = [
    AssetImage("assets/images/frockgold.jpeg"),
    AssetImage("assets/images/rosering.jpeg"),
    AssetImage("assets/images/womenshoes.jpeg"),
    AssetImage("assets/images/mornadibed.jpeg"),
    AssetImage("assets/images/womenbag.jpeg")
  ];
  late User user;
  CartService cartService = CartService();
  List<Product>? products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user = widget.user;
    });
    cartService.getUserCarts(user.id).then((value) {
      setState(() {
        products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carts"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          shrinkWrap: true,
          itemCount: products!.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey.shade200,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(height: 100, width: 80, image: imageList[index]),
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Name: ',
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].title.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Price: ' r"$",
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].price.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Quantity: ',
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].quantity.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Total: ' r"$",
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].total.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Discount Percentage: ',
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].discountPercentage.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Discounted Price: ' r"$",
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                  text: '${products![index].discountedPrice.toString()}\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

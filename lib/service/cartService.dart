import 'package:commerce_flutter/model/cartModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CartService {
  String url = "$api/carts";
  Dio dio = Dio();
  Future<List<Product>?> getCarts() async {
    var response = await dio.get<String>(url);

    try {
      if (response.statusCode == 200) {
        var data = cartModelFromJson(response.data!);
        CartModel cartModel = data;
        List<Product> products = [];
        List<Cart> cartsList = [];

        final List<Cart> cartProducts = cartModel.carts;
        cartsList.addAll(cartProducts);

        for (final product in cartsList) {
          final List<Product> prod = product.products;
          products.addAll(prod);
        }
        return products;
      }
    } catch (e) {
      debugPrint("getcarts fail oldu");
      print("error is $e");
    }
    return null;
  }

  Future<List<Product>?> getSingleCart(int id) async {
    String url = "$api/carts/$id";
    var response = await dio.get<String>(url);

    try {
      if (response.statusCode == 200) {
        var data = cartModelFromJson(response.data!);
        CartModel cartModel = data;
        List<Product> products = [];
        List<Cart> cartsList = [];

        final List<Cart> cartProducts = cartModel.carts;
        cartsList.addAll(cartProducts);

        for (final product in cartsList) {
          final List<Product> prod = product.products;
          products.addAll(prod);
        }
        return products;
      }
    } catch (e) {
      debugPrint("getcarts fail oldu");
      print("error is $e");
    }
    return null;
  }

  Future<List<Product>?> getUserCarts(int id) async {
    String url = "$api/carts/user/$id";
    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = cartModelFromJson(response.data!);
        CartModel cartModel = data; // Update this line

        List<Product> products = [];
        List<Cart> cartsList = [];

        final List<Cart> cartProducts = cartModel.carts;
        cartsList.addAll(cartProducts);

        for (final product in cartsList) {
          final List<Product> prod = product.products;
          products.addAll(prod);
        }
        return products;
      }
    } catch (e) {
      debugPrint("error from get user cart is - $e");
    }
    return null;
  }

  Future<dynamic> addCart(Product product) async {
    String url = "$api/carts/add";
    try {
      var request = await dio.post(url, data: product);
      if (request.statusCode == 201) {
        debugPrint("everythink is okay in addCart");
      }
      return request.data;
    } catch (e) {
      debugPrint("error from add cart is - $e");
    }
  }

  Future<void> deleteCart(int id) async {
    String url = "$api/carts/$id";
    try {
      await dio.delete(url);
    } catch (e) {
      print("Error is $e");
    }
  }

  Future<Product?> putCart({required Product product, required String id}) async {
    Product? updatedProduct;

    try {
      Response response = await dio.put(
        api + '/carts/$id',
        data: product.toJson(),
      );

      debugPrint('Cart updated: ${response.data}');

      updatedProduct = Product.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating Cart: $e');
    }

    return updatedProduct;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/ProductModel.dart';

class ProductService {
  String url = "$api/products?limit=100";
  Dio dio = Dio();
  Future<List<Product>?> getProducts() async {
    var response = await dio.get<String>(url);

    if (response.statusCode == 200) {
      var dat = productModelFromJson(response.data!);

      debugPrint("data yuklendi");
      dat.limit = 100;
      return dat.products;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<Product>?> getProductsLimit(int skip) async {
    String url = "$api/products?limit=20&skip=$skip";
    var response = await dio.get<String>(url);

    if (response.statusCode == 200) {
      var dat = productModelFromJson(response.data!);

      debugPrint("data yuklendi");
      dat.limit = 100;
      return dat.products;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<Product>?> searchProducts(String query) async {
    String url = "$api/products/search?q=$query";
    var response = await dio.get<String>(url);

    if (response.statusCode == 200) {
      var dat = productModelFromJson(response.data!);

      debugPrint("data yuklendi");
      return dat.products;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<String>?> getCategories() async {
    String url = "$api/categories";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      final List<String> data = jsonDecode(response.data);

      debugPrint("hello");
      debugPrint(data[0]);
      return data;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<List<Product>?> getProductsOfCategories(String query) async {
    String url = "$api/categories/$query";
    var response = await dio.get<String>(url);

    if (response.statusCode == 200) {
      var data = productModelFromJson(response.data!);

      return data.products;
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<Product?> getProductOne(var id) async {
    String url = "$api/products/$id";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      debugPrint("data yuklendi");
      return Product.fromJson(response.data);
    } else {
      debugPrint("fail oldi");
    }
    return null;
  }

  Future<void> postProduct(var id, var title, var description, var price, var discountPercentage, var rating, var stock, var brand, var category, var thumbnail, var images) async {
    String url = "$api/products/add";
    Product product = Product(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, brand: brand, category: category, thumbnail: thumbnail, images: images);
    var request = await dio.get(url, data: product);

    if (request.statusCode == 201) {
      debugPrint("everything is okay");
    } else {
      debugPrint("post fail oldi");
    }
  }

  Future<Product?> putProduct({required Product product, required String id}) async {
    Product? updatedProduct;

    try {
      Response response = await dio.put(
        api + '/products/$id',
        data: product.toJson(),
      );

      debugPrint('Product updated: ${response.data}');

      updatedProduct = Product.fromJson(response.data);
    } catch (e) {
      debugPrint('Error updating user: $e');
    }

    return updatedProduct;
  }

  Future<Product?> patchProduct({required Product product, required String id}) async {
    Product? updatedProduct;

    try {
      final dio = Dio();
// Replace with your API base URL

      final response = await dio.patch(
        '$api/products/$id',
        data: product.toJson(),
      );

      if (response.statusCode == 200) {
        updatedProduct = Product.fromJson(response.data);
      } else {
        debugPrint('Error updating product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating product: $e');
    }

    return updatedProduct;
  }

  Future<void> deleteProduct(int id) async {
    String url = "$api/products/$id";
    try {
      await dio.delete(url);
    } catch (e) {
      print("Error is $e");
    }
  }
}

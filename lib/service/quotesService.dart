import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/quoteModel.dart';

class QuotesService {
  Dio dio = Dio();
  Future<List<Quote>?> getAllQuotes() async {
    String url = "$api/quotes";
    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = quotesModelFromJson(response.data!);
        return data.quotes;
      }
    } catch (e) {
      debugPrint("error from get all quotes is - $e");
    }
    return null;
  }

  Future<Quote?> getSingleQuotes(int id) async {
    String url = "$api/quotes/$id";
    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = Quote.fromJson(response.data);
        return data;
      }
    } catch (e) {
      debugPrint("error from get one quote is - $e");
    }
    return null;
  }

  Future<Quote?> getRandomQuotes() async {
    String url = "$api/quotes/random";
    var response = await dio.get(url);
    try {
      if (response.statusCode == 200) {
        var data = Quote.fromJson(response.data);
        return data;
      }
    } catch (e) {
      debugPrint("error from get random quotes is - $e");
    }
    return null;
  }

  Future<List<Quote>?> getLimitQuotes(int skip) async {
    String url = "$api/quotes?limit=25&skip=$skip";
    var response = await dio.get<String>(url);
    try {
      if (response.statusCode == 200) {
        var data = quotesModelFromJson(response.data!);
        return data.quotes;
      }
    } catch (e) {
      debugPrint("error from get limit quotes is - $e");
    }
    return null;
  }
}

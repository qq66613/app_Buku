import 'package:buku_app/models/models_details.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:buku_app/models/models_index.dart';
import 'package:http/http.dart' as http;

class BookControl extends ChangeNotifier {
  BookListResponse? booklist;

  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      booklist = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  DetailBooks? detailResponse;
  fetchDetailBookApi(isbn) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final jsonDetailList = jsonDecode(response.body);
      detailResponse = DetailBooks.fromJson(jsonDetailList);
      notifyListeners();
      fetchSimiliarBookApi(detailResponse!.title!);
    }
  }

  BookListResponse? simliarResponse;
  fetchSimiliarBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final jsonDetailList = jsonDecode(response.body);
      simliarResponse = BookListResponse.fromJson(jsonDetailList);
      notifyListeners();
    }
  }
}

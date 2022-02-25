import 'dart:convert';
import 'package:bookstore_app/models/book.dart';
import 'package:flutter/services.dart' as root_bundle;

class Manager {
  static Future<List<Book>> readJsonData() async {
    final jsondata =
        await root_bundle.rootBundle.loadString('json_data/books_list.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Book.fromJson(e)).toList();
  }
}

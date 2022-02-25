import 'package:bookstore_app/api/firebasemanager.dart';
import 'package:bookstore_app/models/book.dart';
import 'package:bookstore_app/screens/home_screen.dart';
import 'package:bookstore_app/widgets/bookcard.dart';
import 'package:flutter/material.dart';

import 'bookview.dart';

class CartedBooksView extends HomeScreen {
  const CartedBooksView({Key? key}) : super(key: key);

  @override
  _CartedBooksViewState createState() => _CartedBooksViewState();
}

class _CartedBooksViewState extends HomeScreenState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: super.appBarWidget(context),
      body: FutureBuilder(
          future: FirebaseManager.fetchCartedBooks(),
          builder: super.builderMethod),
    );
  }

  @override
  BookCard customItemBuilder(
      List<Book> items, int index, BuildContext context) {
    return BookCard(
      book: items[index],
      function: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookView(book: items[index])));
      },
      isNetworkImage: false,
      isCarted: true,
    );
  }
}

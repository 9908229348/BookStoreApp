import 'package:bookstore_app/api/firebasemanager.dart';
import 'package:bookstore_app/models/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  Book book;
  Function function;
  bool isNetworkImage;
  bool isCarted;

  BookCard(
      {Key? key,
      required this.book,
      required this.function,
      required this.isNetworkImage,
      required this.isCarted})
      : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          widget.function();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                color: Colors.blueGrey[100],
                child: widget.isNetworkImage
                    ? Image.network(widget.book.image!)
                    : Image(
                        image: AssetImage(widget.book.image!),
                        fit: BoxFit.fill,
                      )),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.book.title!,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "by ${widget.book.author!}",
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
            Text(
              'Rs.${widget.book.price}',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:
                                widget.isCarted ? Colors.green : Colors.red),
                        onPressed: () async {
                          if (widget.isCarted)
                            removeFromCart();
                          else
                            addToCart();
                        },
                        child: widget.isCarted
                            ? const Text("Added to Cart")
                            : const Text("Add to Cart")),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("wish list"))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  addToCart() async {
    String result = await FirebaseManager.addBookToCart(widget.book);
    if (result == "success") {
      setState(() {
        widget.isCarted = !widget.isCarted;
      });
    }
  }

  removeFromCart() async {
    String result = await FirebaseManager.removeBookFromCart(widget.book);
    if (result == "success") {
      setState(() {
        widget.isCarted = !widget.isCarted;
      });
    }
  }
}

import 'package:bookstore_app/api/data_read.dart';
import 'package:bookstore_app/models/book.dart';
import 'package:bookstore_app/screens/bookview.dart';
import 'package:bookstore_app/screens/cartbooks.dart';
import 'package:bookstore_app/utils/colors.dart';
import 'package:bookstore_app/utils/global_variables.dart';
import 'package:bookstore_app/widgets/bookcard.dart';
import 'package:bookstore_app/widgets/custom_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isCarted = false;
  List<Book> items = [];

  signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", false);
  }

  @override
  void initState() {
    super.initState();
    signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context),
        body: FutureBuilder(
          future: Manager.readJsonData(),
          builder: builderMethod,
        ));
  }

  Widget builderMethod(context, data) {
    if (data.hasError) {
      return Center(child: Text("${data.error}"));
    } else if (data.hasData) {
      items = data.data as List<Book>;
      return GridView.builder(
          itemCount: items == null ? 0 : items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600
                  ? webCrossAxisCount
                  : mobileCrossAxisCount,
              mainAxisSpacing: axisSpacingForHome,
              crossAxisSpacing: axisSpacingForHome,
              childAspectRatio: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 2)
                  : MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height)),
          itemBuilder: (context, index) {
            return customItemBuilder(items, index, context);
          });
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

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
      isCarted: false,
    );
  }

  PreferredSizeWidget appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsPalette.appBarColor,
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
              height: smallContainersize,
              width: smallContainersize,
              child: Image(
                image: AssetImage('images/book_image.jpeg'),
                fit: BoxFit.fill,
              )),
        ],
      ),
      title: CustomSearchBar(
        searchInputCallBack: () {},
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${items.length}",
                ),
                const Text(
                  "Cart",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartedBooksView()));
                }),
            const SizedBox(
              width: 15,
            )
          ],
        )
      ],
    );
  }
}

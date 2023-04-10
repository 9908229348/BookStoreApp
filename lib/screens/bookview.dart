import 'package:bookstore_app/models/Details.dart';
import 'package:bookstore_app/models/book.dart';
import 'package:bookstore_app/resources/authmethods.dart';
import 'package:bookstore_app/screens/home_screen.dart';
import 'package:bookstore_app/utils/colors.dart';
import 'package:bookstore_app/widgets/details_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class BookView extends HomeScreen {
  Book book;
  BookView({Key? key, required this.book}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState(book);
}

class _BookViewState extends HomeScreenState {
  Book book;
  _BookViewState(this.book);

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _phoneNUmberEditingController = TextEditingController();
  TextEditingController _pinEditingController = TextEditingController();
  TextEditingController _localityEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();
  TextEditingController _cityEditingController = TextEditingController();
  TextEditingController _landMarkEditingController = TextEditingController();

  int _count = 1;
  bool _isExpanded = false;
  DetailsOfUser loggedInUser = DetailsOfUser();
  String _selectedType = 'home';
  bool isTextFieldDisabled = false;

  addDetails() async {
    String result = await AuthMethods().addDetailsOfUser(
        name: _nameEditingController.text,
        phoneNumber: _phoneNUmberEditingController.text,
        pinCode: _pinEditingController.text,
        locality: _localityEditingController.text,
        address: _addressEditingController.text,
        city: _cityEditingController.text,
        landMark: _landMarkEditingController.text,
        type: _selectedType);

    if (result == "success") {
      setState(() {
        isTextFieldDisabled = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    FirebaseFirestore.instance
        .collection("userInfo")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = DetailsOfUser.fromSnap(value);
      _nameEditingController = TextEditingController(text: loggedInUser.name);
      _phoneNUmberEditingController =
          TextEditingController(text: loggedInUser.phoneNumber);
      _pinEditingController = TextEditingController(text: loggedInUser.pinCode);
      _localityEditingController =
          TextEditingController(text: loggedInUser.locality);
      _addressEditingController =
          TextEditingController(text: loggedInUser.address);
      _cityEditingController = TextEditingController(text: loggedInUser.city);
      _landMarkEditingController =
          TextEditingController(text: loggedInUser.landMark);
      _selectedType = loggedInUser.type!;
      setState(() {
        isTextFieldDisabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: super.appBarWidget(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsPalette.colorBlack,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: paddingFifteen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "My cart 7",
                        style: TextStyle(
                            fontSize: smallFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 70,
                              height: 100,
                              child: Image(
                                image: AssetImage(book.image!),
                                fit: BoxFit.fill,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${book.title}",
                                style: const TextStyle(fontSize: smallFontSize),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "by ${book.author}",
                                style: const TextStyle(
                                    fontSize: smallFontSize,
                                    color: Colors.black54),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Rs.${book.price}",
                                style: const TextStyle(
                                    fontSize: smallFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_count > 1) {
                                          _count--;
                                        } else {}
                                      });
                                    },
                                    child: Container(
                                      width: smallContainersize,
                                      height: smallContainersize,
                                      margin:
                                          const EdgeInsets.all(paddingFifteen),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              circularBorderRadius),
                                          color: Colors.black26),
                                      child: const Center(
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: ColorsPalette.colorBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: smallFontSize),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: smallContainersize,
                                    width: smallContainersize,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorsPalette.colorBlack)),
                                    child: Center(
                                      child: Text(
                                        "$_count",
                                        style: const TextStyle(
                                            color: ColorsPalette.colorBlack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: smallFontSize),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _count++;
                                      });
                                    },
                                    child: Container(
                                      width: smallContainersize,
                                      height: smallContainersize,
                                      margin:
                                          const EdgeInsets.all(paddingFifteen),
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(
                                              circularBorderRadius)),
                                      child: const Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: ColorsPalette.colorBlack,
                                              fontSize: smallFontSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _count = 0;
                                        });
                                      },
                                      child: const Text("Remove")),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(screenPadding),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900],
                                  textStyle: const TextStyle(
                                      fontSize: smallFontSize,
                                      fontWeight: FontWeight.bold)),
                              child: const Text("Place Order"),
                              onPressed: () {},
                            ),
                          ))
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(left: paddingFifteen),
                height: _isExpanded
                    ? expandedContainerSize
                    : collapsedContainerSize,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Customer Details",
                          style: TextStyle(fontSize: smallFontSize),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isTextFieldDisabled = false;
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                    if (_isExpanded) expandedDetails(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget expandedDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerDetails(
          context: context,
          text: "Name",
          textEditingController: _nameEditingController,
          isTextEnabled: isTextFieldDisabled,
        ),
        CustomerDetails(
            context: context,
            text: "Phone Number",
            textEditingController: _phoneNUmberEditingController,
            isTextEnabled: isTextFieldDisabled),
        CustomerDetails(
            context: context,
            text: "PinCode",
            textEditingController: _pinEditingController,
            isTextEnabled: isTextFieldDisabled),
        CustomerDetails(
            context: context,
            text: "Locality",
            textEditingController: _localityEditingController,
            isTextEnabled: isTextFieldDisabled),
        CustomerDetails(
            context: context,
            text: "Address",
            textEditingController: _addressEditingController,
            isTextEnabled: isTextFieldDisabled),
        CustomerDetails(
            context: context,
            text: "City/town",
            textEditingController: _cityEditingController,
            isTextEnabled: isTextFieldDisabled),
        CustomerDetails(
            context: context,
            text: "LandMark",
            textEditingController: _landMarkEditingController,
            isTextEnabled: isTextFieldDisabled),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Type",
          style: TextStyle(fontSize: smallFontSize),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'home',
            groupValue: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          title: const Text('Home'),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'work',
            groupValue: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          title: const Text('Work'),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'others',
            groupValue: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          title: const Text('Others'),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(paddingFifteen),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      textStyle: const TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.bold)),
                  child: const Text("Continue"),
                  onPressed: addDetails),
            ))
      ],
    );
  }
}

import 'package:bookstore_app/models/book.dart';
import 'package:bookstore_app/resources/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static Future<List<Book>> fetchCartedBooks() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var uid = _auth.currentUser?.uid;

    CollectionReference<Map<String, dynamic>> ref;
    ref = _fireStore.collection("users").doc(uid).collection("books");
    QuerySnapshot snapShot = await ref.get();
    final allData = snapShot.docs
        .map((doc) => Book.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return allData;
  }

  static Future<String> addBookToCart(Book book) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var uid = _auth.currentUser?.uid;
    DocumentReference documentReference =
        _fireStore.collection("users").doc(uid).collection("books").doc();
    book.id = documentReference.id;
    String photoUrl =
            await StorageMethods().uploadImageToStorage("profilePic", book.image!);
    documentReference.set({
      "id": book.id,
      "image": photoUrl,
      "title": book.title,
      "author": book.author,
      "price": book.price
    });
    if (documentReference != null) {
      return "success";
    }
    return "something went wrong";
  }

  static Future<String> removeBookFromCart(Book book) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var uid = _auth.currentUser?.uid;
    DocumentReference documentReference =
        _fireStore.collection("users").doc(uid).collection("books").doc(book.id);
    documentReference.delete();
      return "success";
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name,
      required String gender}) async {
    String res = "Some error occured";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "name": name,
        "uid": cred.user!.uid,
        "email": email,
        "gender": gender
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occured";
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> addDetailsOfUser(
      {required String name,
      required String phoneNumber,
      required String pinCode,
      required String locality,
      required String address,
      required String city,
      required String landMark,
      required String type}) async {
    String res = "Some error occured";
    try {
      await _firestore
          .collection("userInfo")
          .doc(_auth.currentUser?.uid)
          .set({
        "name": name,
        "phoneNumber": phoneNumber,
        "pinCode": pinCode,
        "locality": locality,
        "address": address,
        "city": city,
        "landMark": landMark,
        "type": type
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

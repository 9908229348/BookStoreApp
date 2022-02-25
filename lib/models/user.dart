import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? gender;

  UserModel({this.uid, this.email, this.name, this.gender});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        gender: map['gender']);
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        name: snapshot["name"],
        uid: snapshot['uid'],
        email: snapshot["email"],
        gender: snapshot['gender']);
  }
}

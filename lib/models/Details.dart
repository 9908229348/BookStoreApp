import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsOfUser {
  String? name;
  String? phoneNumber;
  String? pinCode;
  String? locality;
  String? address;
  String? city;
  String? landMark;
  String? type;

  DetailsOfUser(
      {this.name,
      this.phoneNumber,
      this.pinCode,
      this.locality,
      this.address,
      this.city,
      this.landMark,
      this.type});

  static DetailsOfUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return DetailsOfUser(
        name: snapshot['name'],
        phoneNumber: snapshot['phoneNumber'],
        pinCode: snapshot['pinCode'],
        locality: snapshot['locality'],
        address: snapshot['address'],
        city: snapshot['city'],
        landMark: snapshot['landMark'],
        type: snapshot['type']);
  }
}

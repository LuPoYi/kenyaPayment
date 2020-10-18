import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  Member({
    this.name,
    this.email,
    this.group,
    this.photoURL,
    this.reference,
  });

  String name;
  String email;
  String group;
  String photoURL;
  DocumentReference reference;

  factory Member.fromSnapshot(DocumentSnapshot snapshot) {
    Member newMember = Member.fromJson(snapshot.data());
    newMember.reference = snapshot.reference;
    return newMember;
  }

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["name"],
        email: json["email"],
        group: json["group"],
        photoURL: json["photoURL"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "group": group,
        "photoURL": photoURL,
      };
}



import 'package:acwadcom/helpers/util/t_formater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType {
  normalUser,
  storeOwner,
}

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String userType ;
  final String? storeLink;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
      "storeLink":storeLink,
      "userType": userType 
    };
  }

  UserModel(
      {required this.id,
       this.storeLink = "", 
     required this.userType,
      // required this.lastName,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  ///Helper Function to get FullName
  // String get fullName => '$firstName $lastName';

  ///Helper Function to format phone Number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.spilt(" ");

  ///static function to generate a username from the full Name

  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = 'cwt_$camelCaseUserName';
    return userNameWithPrefix;
  }

  ///static function to create on empty user model
  static UserModel empty() => UserModel(userType:  "",storeLink: "", id: "", userName: "", email: "", phoneNumber: "", profilePicture: "");

  ///Factory method to create a UserModel from a Firebase snapshot.

   factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
     if(doc.data() != null) {
       return UserModel(
          userType: doc["userType"] ?? "",
           id: doc.id,
           userName: doc["userName"] ?? "",
           email: doc["email"] ?? "",
           phoneNumber: doc["phoneNumber"] ?? "",
           profilePicture: doc["profilePicture"] ?? "",
            storeLink: doc["storeLink"] ?? ""
           );
     }
       else{
         return UserModel.empty();
     }
   }

     // Create UserModel from JSON format
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json["id"],
     userName: json["userName"],
      email: json["email"], 
      phoneNumber: json["phoneNumber"], 
      profilePicture: json["profilePicture"], userType: json["userType"]?? "",
      storeLink:json["storeLink"]
      );
  }
}

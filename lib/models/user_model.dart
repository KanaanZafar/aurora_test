import 'package:aurora_test/utils/constants.dart';
import 'package:aurora_test/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  User user;
  String firstName;
  String lastName;
  String phoneNumber;

  UserModel({this.user, this.firstName, this.lastName, this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
     FirebaseConstants.firstName: this.firstName,
     FirebaseConstants.lastName: this.lastName,
     FirebaseConstants.phoneNumber: this.phoneNumber
    };
  }

  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber}';
  }
}

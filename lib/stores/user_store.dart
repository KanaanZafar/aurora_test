import 'package:aurora_test/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

class UserStore with ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel {
    return _userModel;
  }

  initializeUserModel(
      {User user, String firstName, String lastName, String phoneNumber}) {
    _userModel = UserModel();
    _userModel.user = user;
    _userModel.firstName = firstName;
    _userModel.lastName = lastName;
    _userModel.phoneNumber = phoneNumber;
    notifyListeners();
  }

  updateFirstName(String value) {
    _userModel.firstName = value;
    notifyListeners();
  }

  updateLastName(String value) {
    _userModel.lastName = value;
    notifyListeners();
  }

  updatePhoneNumber(String value) {
    _userModel.phoneNumber = value;
    notifyListeners();
  }

  clear() {
    _userModel = null;
    notifyListeners();
  }
}

import 'package:aurora_test/utils/constants.dart';
import 'package:string_validator/string_validator.dart';

String validateName(String value) {
  if (value.isEmpty) {
    return Constants.fillThisFeed;
  }
  return null;
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return Constants.fillThisFeed;
  }
  if (!isEmail(value)) {
    return Constants.invalidEmail;
  }
  return null;
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return Constants.fillThisFeed;
  }
  if (value.length < 6) {
    return Constants.passwordRequiredCharacters;
  }

  return null;
}
String validatePhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string == null || string.isEmpty) {
    return Constants.fillThisFeed;
  }

  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return Constants.invalidPhoneNumber;
  }
  return null;
}

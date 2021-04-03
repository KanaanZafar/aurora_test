import 'package:aurora_test/components/dialog_box.dart';
import 'package:aurora_test/helper/firebase_database_helper.dart';
import 'package:aurora_test/models/user_model.dart';
import 'package:aurora_test/stores/user_store.dart';
import 'package:aurora_test/utils/constants.dart';
import 'package:aurora_test/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

login({
  BuildContext context,
  String email,
  String password,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    Map data = await fetchUserInformation(user.uid);
    if (data != null) {
      userStore.initializeUserModel(
          user: user,
          phoneNumber: data[FirebaseConstants.phoneNumber],
          lastName: data[FirebaseConstants.lastName],
          firstName: data[FirebaseConstants.firstName]);
    }
  } on FirebaseAuthException catch (e) {
    String title = Constants.errorSigningIn;
    String content;
    if (e.code == Constants.userNotFoundCode) {
      content = Constants.noUserFound;
    } else if (e.code == Constants.wrongPasswordCode) {
      content = Constants.wrongPasswordProvided;
    } else {
      content = e.message;
      showDialogBox(
          context: context,
          title: Constants.errorSigningIn,
          content: e.message);
    }
    showDialogBox(context: context, title: title, content: content);
  }
}

signUp(
    {BuildContext context,
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel userModel = UserModel();
    userModel.user = userCredential.user;
    userModel.phoneNumber = phoneNumber;
    userModel.firstName = firstName;
    userModel.lastName = lastName;

    await writeUserInformation(userModel: userModel);
  } on FirebaseAuthException catch (e) {
    String title = Constants.errorSigningUp;
    String content;
    if (e.code == Constants.weakPasswordCode) {
      content = Constants.weakPasswordMessage;
    } else if (e.code == Constants.emailInUseCode) {
      content = Constants.accountExists;
    } else {
      content = e.message;
    }
    showDialogBox(context: context, title: title, content: content);
  }
}

logOut() async {
  await FirebaseAuth.instance.signOut();
}

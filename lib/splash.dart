import 'package:aurora_test/auth_screens/login_screen.dart';
import 'package:aurora_test/helper/firebase_database_helper.dart';
import 'package:aurora_test/home/home.dart';
import 'package:aurora_test/stores/user_store.dart';
import 'package:aurora_test/utils/app_colors.dart';
import 'package:aurora_test/utils/firebase_constants.dart';
import 'package:aurora_test/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserStore userStore;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      User user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        navigate(LoginScreen());
      } else {
        fetchData(user);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.appPrimaryColor),
        ),
      ),
    );
  }

  navigate(Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  fetchData(User user) async {
    Map data = await fetchUserInformation(user.uid);
    userStore.initializeUserModel(
        user: user,
        firstName: data[FirebaseConstants.firstName],
        lastName: data[FirebaseConstants.lastName],
        phoneNumber: data[FirebaseConstants.phoneNumber]);
    navigate(Home());
  }
}

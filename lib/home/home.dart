import 'package:aurora_test/auth_screens/login_screen.dart';
import 'package:aurora_test/components/background_wallpaper.dart';
import 'package:aurora_test/components/primary_button.dart';
import 'package:aurora_test/components/primary_text.dart';
import 'package:aurora_test/helper/auth_helper.dart';
import 'package:aurora_test/stores/user_store.dart';
import 'package:aurora_test/utils/constants.dart';
import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserStore userStore;

  @override
  Widget build(BuildContext context) {
    userStore = Provider.of<UserStore>(context, listen: false);
    if (SizeConfig.screenHeight == null) {
      SizeConfig().init(context);
    }
    return Scaffold(
        body: Stack(
      children: [
        BackgroundWallpaper(),
        Center(
          child: PrimaryText(text: Constants.successfullyLoggedIn),
        ),
        PositionedDirectional(
          bottom: SizeConfig.safeBlockVertical * 5,
          start: SizeConfig.safeBlockHorizontal * 6,
          end: SizeConfig.safeBlockHorizontal * 6,
          child: PrimaryButton(
            onPressed: handleLogOut,
            buttonTitle: Constants.logOut,
          ),
        ),
      ],
    ));
  }

  handleLogOut() async {
    await logOut();
    userStore.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}

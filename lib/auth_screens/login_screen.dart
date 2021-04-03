import 'package:aurora_test/auth_screens/register_screen.dart';
import 'package:aurora_test/components/background_wallpaper.dart';
import 'package:aurora_test/components/primary_text.dart';
import 'package:aurora_test/components/primary_textfield.dart';
import 'package:aurora_test/components/primary_title.dart';
import 'package:aurora_test/home/home.dart';
import 'package:aurora_test/stores/user_store.dart';
import 'file:///D:/AndroidStudioProjects/aurora_test/lib/components/primary_button.dart';
import 'package:aurora_test/utils/app_colors.dart';
import 'package:aurora_test/utils/constants.dart';
import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora_test/helper/auth_helper.dart' as AuthHelper;
import 'package:aurora_test/helper/validators_helper.dart' as ValidatorsHelper;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  UserStore userStore;

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.screenHeight == null) {
      SizeConfig().init(context);
    }
    userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWallpaper(),
          SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 6),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/bmw_logo_big.png",
                      height: SizeConfig.blockSizeVertical * 30,
                      width: SizeConfig.safeBlockHorizontal * 30,
                    ),
                    PrimaryTitle(title: Constants.login),
                    PrimaryTextField(
                        textEditingController: emailController,
                        validator: ValidatorsHelper.validateEmail,
                        hintText: Constants.email),
                    PrimaryTextField(
                      textEditingController: passwordController,
                      hintText: Constants.password,
                      obscureText: true,
                      validator: ValidatorsHelper.validatePassword,
                    ),
                    PrimaryText(text: Constants.forgotPassword),
                    PrimaryButton(
                      buttonTitle: Constants.login.toUpperCase(),
                      onPressed: handleLogin,
                      isLoading: isLoading,
                    ),
                    PrimaryButton(
                      buttonTitle: Constants.register.toUpperCase(),
                      onPressed: register,
                      gradient: LinearGradient(colors: [
                        AppColors.appPrimaryColor.withOpacity(0.7),
                        AppColors.appPrimaryColor.withOpacity(0.7),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  handleLogin() async {
    setState(() {
      isLoading = true;
    });
    if (formKey.currentState.validate()) {
      await AuthHelper.login(
          context: context,
          email: emailController.text,
          password: passwordController.text);
    }
    setState(() {
      isLoading = false;
    });
    if (userStore.userModel != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    } else {}
  }

  register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }
}

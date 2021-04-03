import 'package:aurora_test/components/background_wallpaper.dart';
import 'package:aurora_test/components/primary_text.dart';
import 'package:aurora_test/components/primary_textfield.dart';
import 'package:aurora_test/components/primary_title.dart';
import 'package:aurora_test/helper/auth_helper.dart';
import 'file:///D:/AndroidStudioProjects/aurora_test/lib/components/primary_button.dart';
import 'package:aurora_test/utils/app_colors.dart';
import 'package:aurora_test/utils/constants.dart';
import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:aurora_test/helper/validators_helper.dart' as ValidatorsHelper;
import 'package:toast/toast.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController scrollController = ScrollController();
  double opacity = 0;
  bool isLoading = false;
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.75)) {
        opacity = 1.0;
      } else if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.5)) {
        opacity = 0.8;
      } else if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.25)) {
        opacity = 0.5;
      }
      if (scrollController.offset <
          (scrollController.position.maxScrollExtent * 0.15)) {
        opacity = 0;
      } else if (scrollController.offset <
          (scrollController.position.maxScrollExtent * 0.25)) {
        opacity = 0.3;
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWallpaper(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 6),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 5,
                    ),
                    backButton(),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    PrimaryTitle(title: Constants.welcomeToTitle),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    PrimaryText(
                      text: Constants.letsStart,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 3,
                    ),
                    titleAndField(
                      title: PrimaryText(text: "${Constants.firstName} *"),
                      field: PrimaryTextField(
                        textEditingController: firstNameController,
                        hintText: Constants.firstName,
                        validator: ValidatorsHelper.validateName,
                      ),
                    ),
                    titleAndField(
                      title: PrimaryText(
                        text: "${Constants.lastName} *",
                      ),
                      field: PrimaryTextField(
                        textEditingController: lastNameController,
                        hintText: Constants.lastName,
                        validator: ValidatorsHelper.validateName,
                      ),
                    ),
                    titleAndField(
                      title: PrimaryText(text: "${Constants.email} *"),
                      field: PrimaryTextField(
                        textEditingController: emailController,
                        hintText: Constants.email,
                        validator: ValidatorsHelper.validateEmail,
                      ),
                    ),
                    titleAndField(
                      title: PrimaryText(
                        text: "${Constants.phoneNumber} *",
                      ),
                      field: PrimaryTextField(
                        textEditingController: phoneNumberController,
                        hintText: Constants.phoneNumber,
                        validator: ValidatorsHelper.validatePhoneNumber,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(milliseconds: 200),
                      child: titleAndField(
                        title: PrimaryText(
                          text: "${Constants.password} *",
                        ),
                        field: PrimaryTextField(
                          textEditingController: passwordController,
                          hintText: Constants.password,
                          validator: ValidatorsHelper.validatePassword,
                        obscureText: true,
                        ),
                      ),
                    ),
                    KeyboardVisibilityBuilder(builder: (context, isVisible) {
                      if (isVisible) {
                        return Container();
                      }
                      return Container(
                        height: 80,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          KeyboardVisibilityBuilder(
            controller: keyboardVisibilityController,
            builder: (context, isKeyboardVisible) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: isKeyboardVisible
                    ? Container()
                    : Container(
                        color: Colors.transparent,
                        height: 100,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 6),
                        child: Center(
                          child: PrimaryButton(
                            buttonTitle: Constants.submit.toUpperCase(),
                            isLoading: isLoading,
                            onPressed: submit,
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget backButton() {
    return IconButton(
        icon: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(child: Icon(Icons.arrow_back_ios_sharp)),
        ),
        color: AppColors.appPrimaryColor,
        onPressed: () {
          Navigator.pop(context);
        });
  }

  Widget titleAndField({Widget title, Widget field}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(
          height: SizeConfig.safeBlockVertical,
        ),
        field,
        SizedBox(
          height: SizeConfig.safeBlockVertical * 3,
        ),
      ],
    );
  }

  submit() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await signUp(
          context: context,
          password: passwordController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text);
      setState(() {
        isLoading = false;
      });
      Toast.show(
        Constants.successfullyRegistered,
        context,
      );
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pop(context);
    }
  }
}

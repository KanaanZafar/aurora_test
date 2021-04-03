import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonTitle;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final bool isLoading;

  const PrimaryButton(
      {Key key,
      @required this.buttonTitle,
      this.gradient,
      this.width = double.infinity,
      this.height,
      this.onPressed,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 60,
      decoration: BoxDecoration(
          gradient: gradient ??
              LinearGradient(
                colors: [
                  Colors.orangeAccent.withOpacity(0.8),
                  Colors.orangeAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.9],
              ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: Offset(-1.0, -1.5),
              blurRadius: 2.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: isLoading
                ? Container(
                    height: SizeConfig.safeBlockVertical * 2.5,
                    width: SizeConfig.safeBlockVertical * 2.5,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                : Text(
                    buttonTitle,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}

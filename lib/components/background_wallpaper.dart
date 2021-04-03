import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/material.dart';

class BackgroundWallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/background.png",
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      fit: BoxFit.cover,
    );
  }
}

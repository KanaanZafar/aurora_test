import 'package:aurora_test/utils/size_config.dart';
import 'package:flutter/material.dart';

class PrimaryTitle extends StatelessWidget {
  final String title;

  PrimaryTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: SizeConfig.safeBlockVertical * 5),
    );
  }
}

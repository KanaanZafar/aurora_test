import 'package:aurora_test/utils/constants.dart';
import 'package:flutter/cupertino.dart';

showDialogBox({@required BuildContext context, String title, String content}) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoButton(
                child: Text(Constants.okay),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      });
}

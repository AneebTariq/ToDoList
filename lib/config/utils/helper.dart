import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

void showLoadingDialog(BuildContext context,
    {required Color loaderColor, required double size, bool dismissible = false}) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: loaderColor ?? Colors.blue, // Use default color if not provided
        ),
      );
    },
  );
}

void closeLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}

void showToast(String message,bool isSuccess) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isSuccess==true? AppColors.green:AppColors.red,
    textColor: Colors.white,
    fontSize: 16,
  );
}

void showAlert(
    {required BuildContext context,
      required String title,
      required String description,
      required VoidCallback onCancelPress,
      required VoidCallback onOkPress,
      bool dismissOnTouchOutside = true,
      bool dismissOnBackKeyPress = true}) {
  showDialog(
    context: context,
    barrierDismissible: dismissOnTouchOutside,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description ?? ""),
        actions: <Widget>[
          TextButton(
            onPressed: onCancelPress ?? () => Navigator.of(context).pop(),
            child: Text('Dismiss'),
          ),
          TextButton(
            onPressed: onOkPress,
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

import 'package:coincap/screen/error/internet_connectiondialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Utils{
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static showInternetConnectionAlertDialog({required BuildContext context, var title}) {
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text("Connection Failed"),
      content: InternetConnectionDialog(
        errorMessage: title,
      ),
    );

    // show the error
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
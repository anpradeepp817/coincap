import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class InternetConnectionDialog extends StatelessWidget {
  final String errorMessage;

  const InternetConnectionDialog({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset(
            "images/no_wifi.png",
            width: 90,
            height: 90,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 13),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 13),
          MaterialButton(
            onPressed: () {
              AppSettings.openDataRoamingSettings();
              Navigator.pop(context);
            },
            color: Colors.blue,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text("Open Setting",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
            focusColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

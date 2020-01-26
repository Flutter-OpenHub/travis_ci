import 'package:flutter/material.dart';

class TravisDialog {
  TravisDialog._();

  static showLoading(
      {@required String message, @required BuildContext context}) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ListTile(
              leading: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              title: Text(
                '$message',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          );
        });
  }

  static showWarningWithTitle(
      {@required String title,
      @required String message,
      @required BuildContext context}) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              '$message',
              style: TextStyle(color: Colors.red),
            ),
            title: Text('$title'),
            contentPadding:
                const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }

  static showWarning({@required String text, @required BuildContext context}) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              '$text',
              style: TextStyle(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }
}

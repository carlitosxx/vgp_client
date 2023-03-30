import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context, String text) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.background,
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(text,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ))),
      ],
    ),
    title: null,
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}

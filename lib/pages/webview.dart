import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

Widget newsView(BuildContext context) {
  var args = ModalRoute.of(context)!.settings.arguments;
  print(args.toString());

  return Scaffold(
    appBar: AppBar(
      title: const Text("查看日报"),
    ),
    body: WebView(
      initialUrl: args.toString(),
    ),
  );
}

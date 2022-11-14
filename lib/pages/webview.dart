import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

Widget newsView(BuildContext context) {
  var args = ModalRoute.of(context)!.settings.arguments;

  return Scaffold(
    appBar: AppBar(
      title: const Text("查看日报"),
      backgroundColor: Colors.white,
    ),
    body: myWebView(
      url: args.toString(),
    ),
  );
}

class myWebView extends StatefulWidget {
  const myWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<myWebView> createState() => _myWebViewState();
}

class _myWebViewState extends State<myWebView> {
  late WebViewController _myController;

  void _disableAddAndLink() {
    _myController.runJavascript(
        'document.querySelector("#root > div > main > div > section > div > div > div > div.content-inner > div > a").style.visibility="hidden";'
        'document.querySelector("#root > div > main > div > div > div").style.visibility = "hidden";'
        'document.querySelectorAll("a").forEach((e)=>{e.onclick=(e)=>false;});');
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        _myController = controller;
        _disableAddAndLink();
      },
      onPageStarted: (url) => _disableAddAndLink(),
      onProgress: (url) => _disableAddAndLink(),
      onPageFinished: (initialURL) => _disableAddAndLink(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:zhihu_daily/pages/main_page.drat.dart';
import 'package:zhihu_daily/pages/webview.dart';

Map<String, WidgetBuilder> makeRoutes(BuildContext context) {
  return {
    "/": (context) => mainPage(context),
    "news": (context) => newsView(context),
  };
}

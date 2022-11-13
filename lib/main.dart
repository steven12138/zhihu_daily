import 'package:flutter/material.dart';
import 'package:zhihu_daily/pages/main_page.drat.dart';
import 'package:zhihu_daily/routes/main.dart';

void main() {
  runApp(const MyApp());
}

const noneScheme = ColorScheme(
  primary: Colors.white,
  brightness: Brightness.light,
  onPrimary: Colors.black,
  secondary: Colors.grey,
  onSecondary: Colors.grey,
  error: Colors.red,
  onError: Colors.red,
  background: Colors.white,
  onBackground: Colors.white,
  surface: Colors.transparent,
  onSurface: Colors.transparent,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.yh
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZhiHu Daily',
      initialRoute: "/",
      routes: makeRoutes(context),
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        colorScheme: noneScheme,
      ),
    );
  }
}

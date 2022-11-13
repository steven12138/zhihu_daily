import "package:flutter/material.dart";

import '../components/appbar.dart';

Widget mainPage(BuildContext context) {
  return Scaffold(
    appBar: zBar(context),
    body: mainPageBody(),
  );
}

Widget mainPageBody() {
  return Row();
}

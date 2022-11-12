import 'package:flutter/material.dart';

PreferredSizeWidget zBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: const Date(),
    actions: [
      Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/avatar.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      )
    ],
  );
}

const Map<int, String> monthMap = {
  1: "一月",
  2: "二月",
  3: "三月",
  4: "四月",
  5: "五月",
  6: "六月",
  7: "七月",
  8: "八月",
  9: "九月",
  10: "十月",
  11: "十一月",
  12: "十二月",
};

String parseHour(int hour) {
  return (hour >= 4 && hour <= 11
      ? "早上好~"
      : (hour >= 12 && hour <= 14)
          ? "中午好 ~"
          : (hour >= 15 && hour <= 17)
              ? "下午好~"
              : (hour >= 18 && hour <= 23 || hour <= 4)
                  ? "早点休息~"
                  : "知乎日报");
}

class Date extends StatelessWidget {
  const Date({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    int day = date.day;
    String? month = monthMap[date.month];
    String welcomeHint = parseHour(date.hour);
    return Row(
      children: <Widget>[
        Column(
          children: [
            Text(
              day.toString(),
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              month!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 1.5,
            height: 35,
            margin: const EdgeInsetsDirectional.only(
              start: 10,
              end: 10,
            )),
        Text(welcomeHint),
      ],
    );
  }
}

import 'dart:convert';

import "package:dio/dio.dart";
import 'package:zhihu_daily/components/appbar.dart';
import 'package:zhihu_daily/dto/dailyDTO.dart';

class DioService {
  static final Dio dio = Dio();
  static const latestURL = "https://news-at.zhihu.com/api/3/news/latest";
  static const beforeURL = "https://news-at.zhihu.com/api/3/news/before";

  static Future<News> getDailyNews() async {
    var rawResult = (await dio.get(latestURL)).toString();
    return News.fromJSON(json.decode(rawResult));
  }

  static String parseDate(DateTime date) {
    return "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
  }

  static Future<News> getNewsOn(DateTime date) async {
    var lateDate = date.add(const Duration(days: 1));
    var url = "$beforeURL/${parseDate(lateDate)}";
    var rawResult = (await dio.get(url)).toString();
    return News.fromJSON(json.decode(rawResult));
  }
}

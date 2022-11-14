import 'dart:convert';

import "package:dio/dio.dart";
import 'package:zhihu_daily/components/appbar.dart';
import 'package:zhihu_daily/dto/dailyDTO.dart';

class DioService {
  static final Dio dio = Dio();
  static const latestURL = "https://news-at.zhihu.com/api/3/news/latest";
  static const beforeURL = "https://news-at.zhihu.com/api/3/news/before";

  static Future<List<Story>> getDailyNews() async {
    var rawResult = (await dio.get(latestURL)).toString();
    var stories = json.decode(rawResult)["stories"] as List<dynamic>;
    return List<Story>.from(stories.map((e) => Story.fromJSON(e)));
  }

  static Future<List<Story>> getPosterNews() async {
    var rawResult = (await dio.get(latestURL)).toString();
    var poster = json.decode(rawResult)["top_stories"] as List<dynamic>;
    return List<Story>.from(poster.map((e) => Story.fromJSON(e)));
  }

  static String parseDate(DateTime date) {
    return "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
  }

  static Future<List<Story>> getNewsOn(DateTime date) async {
    var lateDate = date.add(const Duration(days: 1));
    var url = "$beforeURL/${parseDate(lateDate)}";
    var rawResult = (await dio.get(url)).toString();
    var stories = json.decode(rawResult)["stories"] as List<dynamic>;
    return List<Story>.from(stories.map((e) => Story.fromJSON(e)));
  }
}

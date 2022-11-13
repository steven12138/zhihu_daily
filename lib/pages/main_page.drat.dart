import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import "package:flutter/material.dart";
import 'package:zhihu_daily/service/DioService.dart';

import '../components/appbar.dart';
import '../dto/dailyDTO.dart';

Widget mainPage(BuildContext context) {
  return Scaffold(
    appBar: zBar(context),
    body: const MainPageBody(),
  );
}

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<Story> posterNews = [];
  late List<Story> latestNews = [];
  late List<News> historyNews = [];

  void _fresh() {
    setState(() async {
      posterNews = await DioService.getPosterNews();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fresh();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 350,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) => SizedBox(
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.network(
                      posterNews[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    height: 100,
                    bottom: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                        child: Container(
                          alignment: Alignment.topLeft,
                          color: Colors.black.withOpacity(0),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: ListView(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  height: 50,
                                  child: Text(
                                    posterNews[index].title,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Text(
                                  posterNews[index].hint,
                                  style: TextStyle(
                                    color: Colors.grey.shade100,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            control: null,
            duration: 2,
            fade: 0.5,
            physics: const ScrollPhysics(),
            itemCount: posterNews.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(
                bottom: 10,
                right: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

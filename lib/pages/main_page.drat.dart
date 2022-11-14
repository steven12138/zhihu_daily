import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import "package:flutter/material.dart";
import 'package:zhihu_daily/components/daily_news.dart';
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

  final ScrollController _scrollController = ScrollController();

  late List<Story> posterNews = [
    Story(title: "", url: "", hint: "", imageUrl: "")
  ];

  late News currentNews;

  List<News> pastNews = [];

  DateTime lastNews = DateTime.now();
  bool loaded = false;

  bool loadMore = false;

  Future<void> _freshMore(int count) async {
    for (int i = 1; i <= count; i++) {
      lastNews = lastNews.subtract(const Duration(days: 1));
      pastNews.add(News(
        date: lastNews,
        stories: await DioService.getNewsOn(lastNews),
      ));
    }
  }

  Future<void> _fresh() async {
    posterNews = await DioService.getPosterNews();
    currentNews = News(
      date: DateTime.now(),
      stories: await DioService.getDailyNews(),
    );
    lastNews = DateTime.now();
    await _freshMore(3);
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 40) {
        if (!loadMore) {
          loadMore = true;
          await _freshMore(2);
          setState(() {
            loadMore = false;
          });
        }
      }
    });
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
    var swiper = SizedBox(
      height: 390,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          var shade1 = ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                alignment: Alignment.topLeft,
                color: Colors.black.withOpacity(0),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          posterNews[index].hint,
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              "news",
              arguments: posterNews[index].url,
            ),
            child: SizedBox(
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
                    height: 120,
                    bottom: 0,
                    child: shade1,
                  ),
                ],
              ),
            ),
          );
        },
        control: null,
        duration: 2,
        fade: 0.5,
        physics: const ScrollPhysics(),
        itemCount: posterNews.length,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.black45,
            activeColor: Colors.white,
            size: 5,
            activeSize: 5,
          ),
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(
            bottom: 10,
            right: 20,
          ),
        ),
      ),
    );
    if (!loaded) {
      return Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          )
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: _fresh,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) return swiper;
          if (index == 1) return DailyTemplate(newsList: currentNews.stories);
          if (index - 2 >= pastNews.length) {
            return Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            );
          }
          return Daily(news: pastNews[index - 2]);
        },
        itemCount: pastNews.length + 3,
      ),
    );
  }
}

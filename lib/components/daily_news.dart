import 'package:flutter/material.dart';
import 'package:zhihu_daily/service/DioService.dart';

import '../dto/dailyDTO.dart';

class Article extends StatelessWidget {
  const Article({Key? key, required this.article}) : super(key: key);

  final Story article;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          "news",
          arguments: article.url,
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 15,
          ),
          child: ListTile(
            title: Text(article.title),
            subtitle: Text(article.hint),
            trailing: Image.network(article.imageUrl),
          ),
        ),
      ),
    );
  }
}

class DailyNews extends StatefulWidget {
  const DailyNews({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<Story> newsList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print(widget.date);
      newsList = await DioService.getNewsOn(widget.date);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: newsList.map((e) => Article(article: e)).toList(),
    );
    return ListView(
      children: newsList.map((e) => Article(article: e)).toList(),
    );
  }
}

class DailyNewsTemplate extends StatelessWidget {
  const DailyNewsTemplate({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    var myDivider = Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "${date.month}月${date.day}日",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 1,
              margin: const EdgeInsets.only(
                left: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
            ),
          )
        ],
      ),
    );

    return Column(
      children: [
        myDivider,
        DailyNews(date: date),
      ],
    );
  }
}

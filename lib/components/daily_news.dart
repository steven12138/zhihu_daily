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

class DailyTemplate extends StatelessWidget {
  const DailyTemplate({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  final List<Story> newsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: newsList.map((e) => Article(article: e)).toList(),
    );
  }
}

class Daily extends StatelessWidget {
  const Daily({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;

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
              "${news.date.month}月${news.date.day}日",
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
        DailyTemplate(
          newsList: news.stories,
        ),
      ],
    );
  }
}

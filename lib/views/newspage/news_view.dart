import 'package:flutter/material.dart';
import '../widgets/cards/news_card.dart';

class NewsData {
  final String summary;
  final String date;
  final String bannerImage;
  final String url;
  final String source;

  NewsData({
    required this.summary,
    required this.date,
    required this.bannerImage,
    required this.url,
    required this.source,
  });
}

class NewsView extends StatelessWidget {
  final List<NewsData> newsDataList;

  const NewsView({Key? key, required this.newsDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: newsDataList.length,
        itemBuilder: (context, index) {
          final newsData = newsDataList[index];
          return NewsCard(
            summary: newsData.summary,
            date: newsData.date,
            bannerImage: newsData.bannerImage,
            url: newsData.url,
            source: newsData.source,
          );
        },
      ),
    );
  }
}

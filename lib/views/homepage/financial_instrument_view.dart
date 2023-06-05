import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s8_finapp/views/widgets/buttons/expanded_button.dart';
import '../../net/api/alpha_vantage_api.dart';
import '../widgets/stock_chart.dart';
import '../widgets/cards/news_card.dart';

class FinancialInstrument extends StatefulWidget {
  final String instrumentName;
  final String symbol;
  final double price;
  final double percentageChange;
  final double priceChange;
  final String priceChangeSign;

  const FinancialInstrument({
    Key? key,
    required this.instrumentName,
    required this.symbol,
    required this.price,
    required this.percentageChange,
    required this.priceChange,
    required this.priceChangeSign,
  }) : super(key: key);

  @override
  _FinancialInstrumentState createState() =>
      _FinancialInstrumentState();
}

class _FinancialInstrumentState
    extends State<FinancialInstrument> {
  final apiClient = ApiClient(
    baseUrl: 'https://www.alphavantage.co/query',
    apiKey: 'Z4LMVQ381JEKO7PJ',
  );

  Map<String, dynamic>? instrumentData;
  List<StockData> stockDataList = [];

  Future<void> fetchDataForInstrument(String symbol,
      String interval, String apiFunction) async {
    final instrumentApiData = await apiClient
        .fetchInstrumentData(symbol, apiFunction);
    // print(instrumentApiData);
    setState(() {
      instrumentData = instrumentApiData;
      stockDataList = parseStockData(
          instrumentApiData, interval, apiFunction);
    });
  }

  void fetchDataForInterval(String interval) {
    String apiFunction;
    // Conversion of interval time to apiFunction to be used while calling API
    if (interval == '1D') {
      apiFunction = 'TIME_SERIES_DAILY_ADJUSTED';
    } else if (interval == '7D') {
      apiFunction = 'TIME_SERIES_WEEKLY';
    } else if (interval == '30D') {
      apiFunction = 'TIME_SERIES_MONTHLY';
    } else if (interval == '90D') {
      apiFunction = 'TIME_SERIES_MONTHLY';
    } else if (interval == '6m') {
      apiFunction = 'TIME_SERIES_MONTHLY';
    } else if (interval == '1y') {
      apiFunction = 'TIME_SERIES_MONTHLY';
    } else if (interval == 'All') {
      apiFunction = 'TIME_SERIES_MONTHLY';
    } else {
      return;
    }

    // print(apiFunction);
    fetchDataForInstrument(
        widget.symbol, interval, apiFunction);
  }

  List<StockData> parseStockData(
      Map<String, dynamic>? jsonData,
      String interval,
      String apiFunction) {
    late String parsedApiFunction;

    // Retreiving parsedApiFunction to get exact JSON data
    if (apiFunction == 'TIME_SERIES_DAILY_ADJUSTED') {
      parsedApiFunction = 'Time Series (Daily)';
    } else if (apiFunction == 'TIME_SERIES_WEEKLY') {
      parsedApiFunction = 'Weekly Time Series';
    } else if (apiFunction == 'TIME_SERIES_MONTHLY') {
      parsedApiFunction = 'Monthly Time Series';
    } else {
      throw ArgumentError(
          'Invalid apiFunction: $apiFunction');
    }

    final timeSeries = jsonData?[parsedApiFunction];

    final List<StockData> stockDataList = [];

    // Get the keys of the time series data
    final List<String> keys =
        timeSeries?.keys.toList() ?? [];

    // Sort the keys in descending order (assuming the keys represent dates)
    keys.sort((a, b) => b.compareTo(a));

    // Loop through the first 10 keys (latest data points)
    dynamic loopValue;

    if (apiFunction == 'TIME_SERIES_MONTHLY') {
      if (interval == "30D") {
        loopValue = 5;
      } else if (interval == "90D") {
        loopValue = 10;
      } else if (interval == "6m") {
        loopValue = 20;
      } else if (interval == "1y") {
        loopValue = 30;
      } else if (interval == "All") {
        loopValue = keys.length;
      }
    } else {
      loopValue = 5;
    }

    for (int i = 0; i < loopValue && i < keys.length; i++) {
      final key = keys[i];
      final value = timeSeries?[key];

      final stockData = StockData(
        DateTime.parse(key),
        double.parse(value['4. close']),
      );
      stockDataList.add(stockData);
    }

    return stockDataList;
  }

  //
  //
  // This code fetches newsData
  //
  //
  List<NewsData> newsDataList = [];

  Future<List<NewsData>> fetchNewsData(
      String symbol) async {
    final newsData = await apiClient.fetchNewsData(symbol);

    // If News API response is null fallback to stored JSON data
    if (newsData['feed'] == null) {
      String jsonString =
          await DefaultAssetBundle.of(context)
              .loadString('assets/dummy_news_data.json');
      final localNewsData = json.decode(jsonString);

      return parseNewsData(localNewsData);
    } else {
      return parseNewsData(newsData);
    }
  }

  List<NewsData> parseNewsData(
      Map<String, dynamic> newsData) {
    final List<NewsData> newsDataList = [];

    for (var entry in newsData['feed']) {
      final summary = entry['summary'] ?? '';
      dynamic date = entry['time_published'] ?? '';
      final bannerImage = entry['banner_image'] ??
          'https://static.vecteezy.com/system/resources/previews/004/982/490/original/modern-stock-market-logo-vector.jpg';
      final url = entry['url'] ?? '';
      final source = entry['source'] ?? '';

      final parsedDate = DateTime.parse(date);
      final now = DateTime.now();
      final daysAgo = now.difference(parsedDate).inDays;
      final formattedDate =
          daysAgo > 0 ? '$daysAgo days ago' : 'Today';

      final newsItem = NewsData(
        summary: summary,
        date: formattedDate,
        bannerImage: bannerImage,
        url: url,
        source: source,
      );

      newsDataList.add(newsItem);
    }

    return newsDataList;
  }

  @override
  void initState() {
    super.initState();
    fetchDataForInterval('7D');
    fetchNewsData(widget.symbol).then((newsList) {
      setState(() {
        newsDataList = newsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite button tap
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share button tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 10, 18),
          child: SizedBox(
            height: 1300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.instrumentName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${widget.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets
                                    .fromLTRB(5, 3, 3, 3),
                                decoration: BoxDecoration(
                                  color:
                                      widget.percentageChange >=
                                              0
                                          ? Colors.green
                                          : Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(
                                          4),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Icon(
                                      widget.percentageChange >= 0
                                          ? Icons
                                              .arrow_upward
                                          : Icons
                                              .arrow_downward,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Text(
                                      '${widget.percentageChange.toStringAsFixed(2)}%',
                                      style:
                                          const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${widget.priceChangeSign}${widget.priceChange.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                // Stock Chart
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(15))),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      StockChart(stockDataList,
                          fetchDataForInterval),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Follow Button
                ExpandedButton(
                  onPressed: () {
                    // TODO
                  },
                  buttonText: 'Follow',
                  isDarkTheme: false,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Latest News',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: newsDataList.length,
                            itemBuilder: (context, index) {
                              final newsData =
                                  newsDataList[index];
                              return NewsCard(
                                summary: newsData.summary,
                                date: newsData.date,
                                bannerImage:
                                    newsData.bannerImage,
                                url: newsData.url,
                                source: newsData.source,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

import 'package:flutter/material.dart';
import '../../net/api/alpha_vantage_api.dart';
import '../widgets/stock_chart.dart';
import '../widgets/news_card.dart';

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

  Future<void> fetchDataForInstrument(String symbol) async {
    final instrumentApiData =
        await apiClient.fetchData(symbol);

    setState(() {
      instrumentData = instrumentApiData;
      stockDataList = parseStockData(instrumentApiData);
    });
  }

  List<StockData> parseStockData(
      Map<String, dynamic>? jsonData) {
    final timeSeries = jsonData?['Monthly Time Series'];
    final List<StockData> stockDataList = [];

    timeSeries?.forEach((key, value) {
      final stockData = StockData(
        DateTime.parse(key),
        double.parse(value['4. close']),
      );
      stockDataList.add(stockData);
    });

    return stockDataList;
  }

  @override
  void initState() {
    super.initState();
    fetchDataForInstrument(widget.symbol);
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 10, 18),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding:
                                const EdgeInsets.fromLTRB(
                                    5, 3, 3, 3),
                            decoration: BoxDecoration(
                              color:
                                  widget.percentageChange >=
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  widget.percentageChange >=
                                          0
                                      ? Icons.arrow_upward
                                      : Icons
                                          .arrow_downward,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                Text(
                                  '${widget.percentageChange.toStringAsFixed(2)}%',
                                  style: const TextStyle(
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15))),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    StockChart(stockDataList),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle follow button tap
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .white, // Light theme background color
                foregroundColor: Colors
                    .black, // Light theme foreground color
                minimumSize:
                    const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Add news card with dummy data
                  const NewsCard(
                    title: 'News Title',
                    date: 'June 1, 2023',
                    content:
                        'This is a dummy news content.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

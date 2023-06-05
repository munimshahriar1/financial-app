import 'package:flutter/material.dart';
import 'package:s8_finapp/net/api/alpha_vantage_api.dart';
import 'package:s8_finapp/views/widgets/charts/stock_chart_small.dart';

class PortfolioCard extends StatefulWidget {
  final String symbol;
  final double percentageChange;
  final double closingPrice;

  PortfolioCard({
    Key? key,
    required this.symbol,
    required this.percentageChange,
    required this.closingPrice,
  }) : super(key: key);

  @override
  _PortfolioCardState createState() =>
      _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  // Calling API for Stock data for small chart
  final apiClient = ApiClient(
    baseUrl: 'https://www.alphavantage.co/query',
    apiKey: 'Z4LMVQ381JEKO7PJ',
  );

  Map<String, dynamic>? instrumentData;
  List<StockData> stockDataList = [];

  Future<void> fetchDataForInstrument(String symbol) async {
    //  // We will use Daily Stock data for small chart -----> Time Series (Daily)

    const apiFunction = 'TIME_SERIES_DAILY_ADJUSTED';
    final instrumentApiData = await apiClient
        .fetchInstrumentData(symbol, apiFunction);
    // print(instrumentApiData);
    setState(() {
      instrumentData = instrumentApiData;
      stockDataList =
          parseStockData(instrumentApiData, apiFunction);
    });
  }

  List<StockData> parseStockData(
      Map<String, dynamic>? jsonData, String apiFunction) {
    // We will use Daily Stock data for small chart-----> Time Series (Daily)
    const parsedApiFunction = 'Time Series (Daily)';

    final timeSeries = jsonData?[parsedApiFunction];

    // print(timeSeries);
    final List<StockData> stockDataList = [];

    // Get the keys of the time series data
    final List<String> keys =
        timeSeries?.keys.toList() ?? [];
    keys.sort((a, b) => b.compareTo(a));

    // Loop through the first 30 keys (latest data points)
    const loopValue = 100;

    for (int i = 0; i < loopValue && i < keys.length; i++) {
      final key = keys[i];
      final value = timeSeries?[key];

      final stockData = StockData(
        DateTime.parse(key),
        double.parse(value['4. close']),
      );
      stockDataList.add(stockData);
    }

    // print(stockDataList);

    return stockDataList;
  }

  @override
  void initState() {
    super.initState();
    // TODO: This will become dynamic
    fetchDataForInstrument('AAPL');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(8, 22, 0, 2),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.percentageChange.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: widget.percentageChange >= 0
                            ? Colors.green
                            : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 10),
              // Small Stock Chart
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Container(
                  width: 120,
                  child: Column(
                    children: [
                      StockChartSmall(stockDataList),
                    ],
                  ),
                ),
              ),
              // const SizedBox(width: 15),
              Text(
                '\$${widget.closingPrice}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Show modal for "Unfollow"
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Unfollow',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

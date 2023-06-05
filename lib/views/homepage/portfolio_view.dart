import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:s8_finapp/net/api/alpha_vantage_api.dart';
import 'package:s8_finapp/views/homepage/financial_instrument_view.dart';
import 'package:s8_finapp/views/widgets/cards/portfolio_card.dart';
import 'package:s8_finapp/views/widgets/circular_loading_widget.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({
    Key? key,
  }) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final apiClient = ApiClient(
    apiKey: '3QXYGCR2HOYOHP5G',
  );

  bool showSearchBar = true;
  TextEditingController searchController =
      TextEditingController();

  List<Map<String, dynamic>> financialInstruments = [];
  bool isLoading = true; // Track the loading state

  @override
  void initState() {
    super.initState();
    loadSP500Data().then((_) {
      fetchDataForInstruments().then((_) {
        setState(() {
          isLoading =
              false; // Update loading state when data is fetched
        });
      });
    });
  }

  Future<void> loadSP500Data() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/stock_top10.json');
    List<dynamic> sp500Data = json.decode(jsonString);

    // Get the top 5 items from the JSON list
    List<Map<String, dynamic>> top5Data = sp500Data
        .sublist(0, 3)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    financialInstruments = top5Data;
  }

  Future<void> fetchDataForInstruments() async {
    for (final instrument in financialInstruments) {
      final instrumentApiData =
          await apiClient.fetchInstrumentData(
              instrument['Symbol'],
              'TIME_SERIES_DAILY_ADJUSTED');
      processInstrumentData(instrumentApiData, instrument);
    }
    // print(financialInstruments);
  }

  void processInstrumentData(
    Map<String, dynamic> instrumentData,
    Map<String, dynamic> instrument,
  ) {
    final dailyTimeSeries =
        instrumentData['Time Series (Daily)'];

    final latestDate = dailyTimeSeries?.keys.first;
    final previousDate = dailyTimeSeries?.keys.elementAt(1);

    final latestClosingPrice = double.parse(
      dailyTimeSeries?[latestDate ?? '']?['4. close'] ??
          '0.0',
    );

    final previousClosingPrice = double.parse(
      dailyTimeSeries?[previousDate ?? '']?['4. close'] ??
          '0.0',
    );

    final priceChange =
        latestClosingPrice - previousClosingPrice;

    final percentageChange = previousClosingPrice != 0.0
        ? (priceChange / previousClosingPrice) * 100
        : 0.0;

    setState(() {
      instrument['price'] = latestClosingPrice;
      instrument['percentageChange'] = percentageChange;
      instrument['priceChange'] = priceChange;
      instrument['priceChangeSign'] =
          priceChange >= 0 ? '+' : '-'; // Add this line
    });
  }

  void _navigateToDetailsPage(
    String instrumentName,
    String symbol,
    double price,
    double percentageChange,
    double priceChange,
    String priceChangeSign,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinancialInstrument(
          instrumentName: instrumentName,
          symbol: symbol,
          price: price,
          percentageChange: percentageChange,
          priceChange: priceChange,
          priceChangeSign: priceChangeSign,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(14, 14, 10, 0),
            child: Row(
              children: const [
                Text(
                  'Portfolio',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          isLoading
              ? const CircularLoading()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: financialInstruments
                        .map((instrument) {
                      final double price =
                          instrument['price'] ?? 0.0;
                      final double percentageChange =
                          instrument['percentageChange'] ??
                              0.0;
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          // child: Column(
                          child: GestureDetector(
                            onTap: () {
                              _navigateToDetailsPage(
                                instrument['Name'],
                                instrument['Symbol'],
                                instrument['price'],
                                instrument[
                                    'percentageChange'],
                                instrument['priceChange'],
                                instrument[
                                    'priceChangeSign'],
                              );
                            },
                            child: PortfolioCard(
                              symbol: instrument['Symbol'],
                              percentageChange:
                                  percentageChange,
                              closingPrice: price,
                            ),

                            // ),
                          ));
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }
}

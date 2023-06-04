import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/financial_instrument_card.dart';
import '../widgets/search_bar_widget.dart';
import '../../net/api/alpha_vantage_api.dart';
import '../homepage/financial_instrument_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final apiClient = ApiClient(
    baseUrl: 'https://www.alphavantage.co/query',
    apiKey: 'Z4LMVQ381JEKO7PJ',
  );

  bool showSearchBar = true;
  TextEditingController searchController =
      TextEditingController();

  List<Map<String, dynamic>> financialInstruments = [];

  @override
  void initState() {
    super.initState();
    loadSP500Data().then((_) {
      fetchDataForInstruments();
    });
  }

  Future<void> loadSP500Data() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/s&p500.json');
    List<dynamic> sp500Data = json.decode(jsonString);

    // Get the top 5 items from the JSON list
    List<Map<String, dynamic>> top5Data = sp500Data
        .sublist(0, 5)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    financialInstruments = top5Data;
  }

  Future<void> fetchDataForInstruments() async {
    for (final instrument in financialInstruments) {
      final instrumentApiData =
          await apiClient.fetchData(instrument['Symbol']);
      processInstrumentData(instrumentApiData, instrument);
    }
    print(financialInstruments);
  }

  void processInstrumentData(
    Map<String, dynamic> instrumentData,
    Map<String, dynamic> instrument,
  ) {
    final monthlyTimeSeries =
        instrumentData['Monthly Time Series'];

    final latestDate = monthlyTimeSeries?.keys.first;
    final previousDate =
        monthlyTimeSeries?.keys.elementAt(1);

    final latestClosingPrice = double.parse(
      monthlyTimeSeries?[latestDate ?? '']?['4. close'] ??
          '0.0',
    );

    final previousClosingPrice = double.parse(
      monthlyTimeSeries?[previousDate ?? '']?['4. close'] ??
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
      String priceChangeSign) {
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
                const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      showSearchBar = !showSearchBar;
                    });
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: showSearchBar,
            child: SearchBar(
              hintText: 'Search interests to follow',
              onClose: () {
                setState(() {
                  searchController.clear();
                });
              },
              textController: searchController,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Gainers and Losers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Handle "See All" button tap
                  },
                  label: Row(
                    children: const [
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  icon: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 185,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  financialInstruments.map((instrument) {
                final double price =
                    instrument['price'] ?? 0.0;
                final double percentageChange =
                    instrument['percentageChange'] ?? 0.0;
                final double priceChange =
                    instrument['priceChange'] ?? 0.0;
                final String priceChangeSign =
                    instrument['priceChangeSign'] ?? '+';

                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateToDetailsPage(
                          instrument['Name'],
                          instrument['Symbol'],
                          instrument['price'],
                          instrument['percentageChange'],
                          instrument['priceChange'],
                          instrument['priceChangeSign'],
                        );
                      },
                      child: FinancialInstrumentCard(
                        logoUrl:
                            'https://static.vecteezy.com/system/resources/previews/002/520/838/original/apple-logo-black-isolated-on-transparent-background-free-vector.jpg',
                        instrumentName:
                            instrument['Symbol'],
                        price: price,
                        percentageChange: percentageChange,
                        priceChange: priceChange,
                        priceChangeSign: priceChangeSign,
                      ),
                    ));
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Your Watchlist',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Handle "See All" button tap
                  },
                  label: Row(
                    children: const [
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  icon: const SizedBox.shrink(),
                ),
              ],
            ),
          ),

          // Add your watchlist content here
        ],
      ),
    );
  }
}

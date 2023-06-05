import 'package:flutter/material.dart';
import 'package:s8_finapp/views/widgets/cards/portfolio_card.dart';
import 'package:s8_finapp/views/widgets/cards/user_info_card.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({
    Key? key,
  }) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                PortfolioCard(
                  symbol: 'AAPL',
                  percentageChange: 2.5,
                  closingPrice: 135,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FinancialInstrumentCard extends StatelessWidget {
  final String logoUrl;
  final String instrumentName;
  final double price;
  final double percentageChange;
  final double priceChange;

  const FinancialInstrumentCard({
    required this.logoUrl,
    required this.instrumentName,
    required this.price,
    required this.percentageChange,
    required this.priceChange,
  });

  @override
  Widget build(BuildContext context) {
    Color boxColor =
        percentageChange >= 0 ? Colors.green : Colors.red;

    return SizedBox(
      width: 190,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(17.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  image: DecorationImage(
                    image: NetworkImage(logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    instrumentName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                        5, 3, 3, 3),
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius:
                          BorderRadius.circular(4),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${percentageChange.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          percentageChange >= 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 4),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(9, 4, 1, 1),
                    child: Text(
                      '\$${priceChange.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

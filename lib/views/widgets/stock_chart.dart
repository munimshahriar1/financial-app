import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StockData {
  final DateTime date;
  final double closingPrice;

  StockData(this.date, this.closingPrice);
}

class StockChart extends StatefulWidget {
  final List<StockData> stockDataList;
  final Function(String) onIntervalSelected;

  const StockChart(
      this.stockDataList, this.onIntervalSelected,
      {Key? key})
      : super(key: key);

  @override
  _StockChartState createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  String selectedInterval = '7D';
  final List<String> intervals = [
    '1H',
    '1D',
    '7D',
    '30D',
    '90D',
    '6m',
    '1y',
    'All'
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StockData, DateTime>> seriesList = [
      charts.Series(
        id: 'Stock Data',
        data: widget.stockDataList,
        domainFn: (StockData data, _) => data.date,
        measureFn: (StockData data, _) => data.closingPrice,
        colorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
    ];

    return Expanded(
      child: Column(
        children: [
          Row(
            children: intervals.map((interval) {
              bool isSelected =
                  interval == selectedInterval;
              return Padding(
                padding:
                    const EdgeInsets.fromLTRB(4, 0, 0, 12),
                child: Expanded(
                  child: Container(
                    width:
                        46, // Set a specific width for the buttons
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedInterval = interval;
                        });
                        widget.onIntervalSelected(interval);
                      },
                      style: ButtonStyle(
                        backgroundColor: isSelected
                            ? MaterialStateProperty.all<
                                Color>(Colors.white)
                            : null,
                        foregroundColor: isSelected
                            ? MaterialStateProperty.all<
                                Color>(Colors.black)
                            : MaterialStateProperty.all<
                                Color>(Colors.white),
                      ),
                      child: Text(
                        interval,
                        style: const TextStyle(
                          fontSize:
                              14, // Decrease font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.fromLTRB(20, 0, 5, 0),
              color: Colors.transparent,
              child: charts.TimeSeriesChart(
                seriesList,
                animate: true,
                defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  stacked: false,
                  areaOpacity: 0.1,
                  includePoints: false,
                  strokeWidthPx: 3.0,
                ),
                domainAxis: const charts.DateTimeAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                      color: charts.MaterialPalette.white,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts.Color
                          .transparent, // Remove grid lines
                    ),
                  ),
                  // tickProviderSpec:
                  //     charts.DayTickProviderSpec(
                  //   increments: [
                  //     1,
                  //     7,
                  //     30
                  //   ], // Set desired intervals in days
                  // ),
                ),
                primaryMeasureAxis:
                    const charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                      color: charts.MaterialPalette.white,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts
                          .Color.white, // Remove grid lines
                      dashPattern: [
                        1,
                        15
                      ], // Dotted line pattern
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

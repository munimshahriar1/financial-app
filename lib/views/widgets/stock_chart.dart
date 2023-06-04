import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StockData {
  final DateTime date;
  final double closingPrice;

  StockData(this.date, this.closingPrice);
}

class StockChart extends StatelessWidget {
  final List<StockData> stockDataList;

  const StockChart(this.stockDataList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StockData, DateTime>> seriesList = [
      charts.Series(
        id: 'Stock Data',
        data: stockDataList,
        domainFn: (StockData data, _) => data.date,
        measureFn: (StockData data, _) => data.closingPrice,
        colorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
    ];

    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
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
                color: charts
                    .Color.transparent, // Remove grid lines
              ),
            ),
          ),
          primaryMeasureAxis: const charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontSize: 12,
                color: charts.MaterialPalette.white,
              ),
              lineStyle: charts.LineStyleSpec(
                color:
                    charts.Color.white, // Remove grid lines
                dashPattern: [1, 15], // Dotted line pattern
              ),
            ),
          ),
        ),
      ),
    );
  }
}

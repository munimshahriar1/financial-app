import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StockData {
  final DateTime date;
  final double closingPrice;

  StockData(this.date, this.closingPrice);
}

class StockChartSmall extends StatefulWidget {
  final List<StockData> stockDataList;

  const StockChartSmall(this.stockDataList, {Key? key})
      : super(key: key);

  @override
  _StockChartSmallState createState() =>
      _StockChartSmallState();
}

class _StockChartSmallState extends State<StockChartSmall> {
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
          Expanded(
            child: Container(
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
                // domainAxis: const charts.OrdinalAxisSpec(
                //     showAxisLine: true,
                //     renderSpec: charts.NoneRenderSpec()),
                primaryMeasureAxis:
                    const charts.NumericAxisSpec(
                        renderSpec:
                            charts.NoneRenderSpec()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

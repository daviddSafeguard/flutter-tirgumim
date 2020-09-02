import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// class SalesData {
//   SalesData(this.year, this.sales, this.loss);
//   final double year;
//   final double sales;
//   final double loss;
// }
class SalesData {
  SalesData(this.year, this.sales); //,// this.loss);
  final String year;
  final double sales;
  //final double loss;
}

class ColumnChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final List<SalesData> chartData = [
    //   SalesData(2010, 35, 23),
    //   SalesData(2011, 38, 49),
    //   SalesData(2012, 34, 12),
    //   SalesData(2013, 52, 33),
    //   SalesData(2014, 200, 30),
    // ];

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Half yearly sales analysis'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                  dataSource: <SalesData>[SalesData('Jan', 35), SalesData('Feb', 28), SalesData('Mar', 34), SalesData('Apr', 32), SalesData('May', 40)],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]))));

    // SfCartesianChart(
    //         enableAxisAnimation: true,

    //         // Columns will be rendered back to back
    //         enableSideBySideSeriesPlacement: true,
    //         series: <ChartSeries>[
    //           ColumnSeries<SalesData, double>(
    //             dataSource: chartData,
    //             xValueMapper: (SalesData sales, _) => sales.year,
    //             yValueMapper: (SalesData sales, _) => sales.sales,
    //           ),
    //           ColumnSeries<SalesData, double>(
    //             opacity: 0.9,
    //             width: 0.4,
    //             dataSource: chartData,
    //             xValueMapper: (SalesData sales, _) => sales.year,
    //             yValueMapper: (SalesData sales, _) => sales.loss,
    //           )
    //         ]);
  }
}

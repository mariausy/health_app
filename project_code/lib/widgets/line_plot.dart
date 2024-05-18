import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:moder8/models/heartdata.dart';

/// Local import

///Renders default line series chart
class HeartDataPlot extends StatelessWidget {
  ///Creates default line series chart
  HeartDataPlot({Key? key, required this.heartData}) : super(key: key);

  final List<HeartData> heartData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Yesterday heart_rate'),
      primaryXAxis: const DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value} heart_rate',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getHeartDataSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<HeartData, DateTime>> _getHeartDataSeries() {
    return <LineSeries<HeartData, DateTime>>[
      LineSeries<HeartData, DateTime>(
          dataSource: heartData,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'Heart_rate',
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }//_getStepDataSeries

}//StepDataPlot
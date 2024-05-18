import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:moder8/models/heartdata.dart';
import 'package:moder8/models/stepdata.dart';

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

///Renders default line series chart
class StepDataCircle extends StatelessWidget {
  ///Creates default line series chart
  StepDataCircle({Key? key, required this.stepData}) : super(key: key);

  final List<StepData> stepData;

  @override
  Widget build(BuildContext context) {
      return SfCircularChart(  
        title: ChartTitle(text: 'Step goal'),      
        series: _getStepDataCircleSeries(),
      );  
  }

  /// The method returns line series to chart.
  List<CircularSeries> _getStepDataCircleSeries() {
    int steps=0;
    DateTime date = DateTime.now();
    for(StepData sample in stepData){
      steps += sample.value;
      date = sample.time;
    }
    final List<ChartData> chartData = [
        ChartData(date.toString(), steps.toDouble()),
    ];

    return <CircularSeries>[
        // Renders radial bar chart
        RadialBarSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            trackOpacity: 0.3,
            maximumValue: 10000,
            cornerStyle: CornerStyle.bothCurve,
            pointColorMapper: (ChartData data, _) => Color.fromRGBO(69, 187, 161, 1))
    ];
  }//_getStepDataSeries

}//StepDataPlot

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:moder8/models/heartdata.dart';
import 'package:moder8/models/stepdata.dart';
import 'package:moder8/models/sleepdata.dart';

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
      title: ChartTitle(text: 'Heart rate'),
      primaryXAxis: const DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value} bpm',
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
          color: const Color.fromRGBO(69, 187, 161, 1),
          name: 'bpm')
    ];
  }

}//StepDataPlot

///Renders default line series chart
class DailyCircle extends StatelessWidget {
  ///Creates default line series chart
  DailyCircle({Key? key, required this.stepData, required this.sleepData}) : super(key: key);

  final List<StepData> stepData;
  final List<SleepData> sleepData;

  @override
  Widget build(BuildContext context) {
      return SfCircularChart(  
        title: ChartTitle(text: 'Daily goals'),      
        series: _getDataCircleSeries(),
      );  
  }

  /// The method returns line series to chart.
  List<CircularSeries> _getDataCircleSeries() {
    int steps=0;
    for(StepData sample in stepData){
      steps += sample.value;
    }

    final List<ChartData> chartData = [
        ChartData('Steps', steps.toDouble(), Color.fromRGBO(69, 187, 161, 1)),
        //convert goal to be maximum 10000 (same as the step goal) is done by finding percentage and scaling
        ChartData('Sleep', sleepData.first.minutesAsleep.toDouble()*10000/420, const Color.fromRGBO(145, 132, 202, 1)),
    ];

    return <CircularSeries>[
        // Renders radial bar chart
        RadialBarSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelMapper: (ChartData data, _) => data.x,
            trackOpacity: 0.3,
            gap: '10%',
            maximumValue: 10000,
            cornerStyle: CornerStyle.bothCurve,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            pointColorMapper: (ChartData data, _) => data.color),
    ];
  }//_getStepDataSeries

}//StepDataPlot

class ChartData {
  ChartData(this.x, this.y,this.color);
  final String x;
  final double y;
  final Color color;
}
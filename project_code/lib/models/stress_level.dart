import 'package:moder8/models/heartdata.dart';
import 'dart:math';

class StressLevel{
  ///Creates default line series chart
  StressLevel({required this.heartData});
  
  final List<HeartData> heartData;
  int hrvIndex = 0;

  String calculateStressLevel(){
    if (heartData.isEmpty){
      return "No data"; // Add a default return statement
    }
    else{
      List<HeartData> lastTwoMinutesHeartData = getLastTwoMinutesHeartData();
      
      List<double> rrIntervals = [];
      for (HeartData heartRate in lastTwoMinutesHeartData) {
        if (heartRate.value != 0) {
          double rr = 60000 / heartRate.value;
          rrIntervals.add(rr);
        }
      }

      if (rrIntervals.isEmpty) {
        return "No valid data"; // Handle case with no valid RR intervals
      }

      double rmssd = calculateRMSSD(rrIntervals);
      hrvIndex = stressLevels(rmssd);

      return stressLevelsText();

      /*
      double rr = 0;
      double rrTotal = 0;
      double rrMax = 0;
      
      for (HeartData heartRate in lastTwoMinutesHeartData){
        if (heartRate.value != 0){
          rr = 60000/heartRate.value;
          rrTotal += rr;
          if (rr > rrMax){
            rrMax = rr;
          }
        }
      }
      hrvIndex = (rrTotal/rrMax).round();
    return stressLevels(hrvIndex);
    */
    }
  }

  List<HeartData> getLastTwoMinutesHeartData() {
    DateTime lastTime = heartData.last.time;
    DateTime twoMinutesAgo = lastTime.subtract(Duration(minutes: 2));
    return heartData.where((data) => data.time.isAfter(twoMinutesAgo)).toList();
  }

  double calculateMeanRR(List<double> rrIntervals) {
    double sum = rrIntervals.reduce((a, b) => a + b);
    return sum / rrIntervals.length;
  }

  double calculateRMSSD(List<double> rrIntervals) {
    double sumSquaredDiffs = 0;
    for (int i = 0; i < rrIntervals.length - 1; i++) {
      double diff = rrIntervals[i + 1] - rrIntervals[i];
      sumSquaredDiffs += pow(diff, 2);
    }
    return sqrt(sumSquaredDiffs / (rrIntervals.length - 1));
  }

  int stressLevels(double rmssd){
    if (rmssd > 50) return 1;  // Very low stress
    if (rmssd > 40) return 2;  // Low stress
    if (rmssd > 30) return 3;  // Moderate stress
    if (rmssd > 15) return 4;  // High stress
    return 5;                  // Very high stress
  }

  int getstressLevels(){
    if (hrvIndex == 1){
      return 1;
    }
    else if (hrvIndex == 2){
      return 2;
    }
    else if (hrvIndex == 3){
      return 3;
    }
    else if (hrvIndex == 4){
      return 4;
    }
    else if (hrvIndex == 5){
      return 5;
    }
    else {
      return 0;
    }
  }

  String stressLevelsText(){
    if (hrvIndex == 1){
      return "1 - Verry low stress";
    }
    else if (hrvIndex == 2){
      return "2 - Low stress";
    }
    else if (hrvIndex == 3){
      return "3 - Moderate stress";
    }
    else if (hrvIndex == 4){
      return "4 - High stress";
    }
    else if (hrvIndex == 5){
      return "5 - Very high stress";
    }
    else {
      return "No stress data, synchronize the app";
    }
  }
}//StepDataPlot

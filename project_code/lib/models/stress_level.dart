import 'package:flutter/material.dart';
import 'package:moder8/models/heartdata.dart';

class StressLevel{
  ///Creates default line series chart
  StressLevel({required this.heartData});
  
  final List<HeartData> heartData;
  int hrvIndex = 1;

  String calculateStressLevel(){
    if (heartData.isEmpty){
      return "No data"; // Add a default return statement
    }
    else{
      List<HeartData> lastTwoMinutesHeartData = getLastTwoMinutesHeartData();
      
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
    }
  }

  List<HeartData> getLastTwoMinutesHeartData() {
    DateTime lastTime = heartData.last.time;
    DateTime twoMinutesAgo = lastTime.subtract(Duration(minutes: 2));
    return heartData.where((data) => data.time.isAfter(twoMinutesAgo)).toList();
  }

  String stressLevels(int hrvIndex){
    if (hrvIndex > 1 && hrvIndex <= 20){
      return "$hrvIndex - High";
    }
    else if (hrvIndex > 20 && hrvIndex <= 55){
      return "$hrvIndex - Moderate";
    }
    else if (hrvIndex > 55){
      return "$hrvIndex - Low";
    }
    else {
      return "Something went wrong, refresh app";
    }
  }

  int getstressLevels(){
    if (hrvIndex > 1 && hrvIndex <= 20){
      return 3;
    }
    else if (hrvIndex > 20 && hrvIndex <= 55){
      return 2;
    }
    else if (hrvIndex > 55){
      return 1;
    }
    else {
      return 0;
    }
  }
}//StepDataPlot

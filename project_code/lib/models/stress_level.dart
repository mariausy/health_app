import 'package:flutter/material.dart';
import 'package:moder8/models/heartdata.dart';

class StressLevel extends StatelessWidget {
  ///Creates default line series chart
  StressLevel({Key? key, required this.heartData}) : super(key: key);
  
  final List<HeartData> heartData;
  
  @override
  Widget build(BuildContext context) {
    String stressLevel = calculateStressLevel(); // Call the method and store the result
    return Scaffold(
      appBar: AppBar(
        title: Text('Stress Level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Stress level: $stressLevel', // Use the result here
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String calculateStressLevel(){
    /*
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
      double hrvIndex = rrTotal/rrMax;
      */
    return stressLevels(50);
//    }
  }
/*
  List<HeartData> getLastTwoMinutesHeartData() {
    DateTime lastTime = heartData.last.time;
    DateTime twoMinutesAgo = lastTime.subtract(Duration(minutes: 2));
    return heartData.where((data) => data.time.isAfter(twoMinutesAgo)).toList();
  }
*/
  String stressLevels(double hrvIndex){
    if (hrvIndex > 1 && hrvIndex <= 20){
      return "$hrvIndex - Stressed";
    }
    else if (hrvIndex > 20 && hrvIndex <= 55){
      return "$hrvIndex - Neutral";
    }
    else if (hrvIndex > 55){
      return "$hrvIndex - Deeply Relaxed";
    }
    else {
      return "Something went wrong, refresh app";
    }
  }
}//StepDataPlot

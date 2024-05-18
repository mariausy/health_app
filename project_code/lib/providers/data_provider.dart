import 'package:flutter/material.dart';
import 'package:moder8/models/stepdata.dart';
import 'package:moder8/services/impact.dart';
import 'package:moder8/models/heartdata.dart';

class DataProvider extends ChangeNotifier {

  //This serves as database of the application
  List<StepData> stepData = [];
  List<HeartData> heartData = [];

  //Method to fetch step data from the server
  void fetchStepData(String day) async {

    //Get the response
    final data = await ImpactService.fetchStepData(day);

    //if OK parse the response adding all the elements to the list, otherwise do nothing
    if (data != null) {
      for (var i = 0; i < data['data']['data'].length; i++) {
        stepData.add(
            StepData.fromJson(data['data']['date'], data['data']['data'][i]));
      } //for

      //remember to notify the listeners
      notifyListeners();
    }//if

  }//fetchStepData

  void fetchHeartData(String day) async {

  //Get the response
    final data = await ImpactService.fetchHeartData(day);

    //if OK parse the response adding all the elements to the list, otherwise do nothing
    if (data != null) {
      for (var i = 0; i < data['data']['data'].length; i++) {
        heartData.add(
            HeartData.fromJson(data['data']['date'], data['data']['data'][i]));
      } //for

      //remember to notify the listeners
      notifyListeners();
    }//if

  }//fetchStepData

  //Method to clear the "memory"
  void clearData() {
    stepData.clear();
    heartData.clear();
    notifyListeners();
  }//clearData
  
}//DataProvider
import 'package:intl/intl.dart';

class HeartData{
  final DateTime time;
  final int value;

  HeartData({required this.time, required this.value});

  HeartData.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      //value = int.parse(json["value"]);  -for steps
      value = json["value"];

  @override
  String toString() {
    return 'Heart_rate_Data(time: $time, value: $value)';
  }//toString
}//Heart
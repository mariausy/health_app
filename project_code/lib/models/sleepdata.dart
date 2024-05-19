class SleepData{
  final String dateOfSleep;
  final int minutesAsleep;

  SleepData({required this.dateOfSleep, required this.minutesAsleep});

  SleepData.fromJson(String date, Map<String, dynamic> json) :
      dateOfSleep = json["dateOfSleep"],
      minutesAsleep = json["minutesAsleep"];

  @override
  String toString() {
    return 'SleepData(dateOfSleep: $dateOfSleep, minutesAsleep: $minutesAsleep)';
  }//toString
}

// dateOfSleep: day associated to the sleep entry (MM-DD format)
// minutesAsleep: the number of minutes asleep during the sleep entry
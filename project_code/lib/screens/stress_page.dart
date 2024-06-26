import 'package:flutter/material.dart';

class StressPage extends StatelessWidget {
  final int stressLevel; // Value to determine which body to show

  StressPage({Key? key, required this.stressLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (stressLevel == 1) {
      bodyContent = Center(
        child: Card(
          color: Colors.green[100],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_very_satisfied, size: 50, color: Colors.green),
                Text('Very Low Stress', style: TextStyle(fontSize: 24)),
                Text('Your stress level is really good, keep it like that!',style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
      } else if (stressLevel == 2) {
      bodyContent = Center(
        child: Card(
          color: Colors.orange[100],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_satisfied, size: 50, color: Colors.lightGreen),
                Text('Low Stress', style: TextStyle(fontSize: 24)),
                Text('Keep up your good habits and make sure you get enough rest.',style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );

    } else if (stressLevel == 3) {
      bodyContent = Center(
        child: Card(
          color: Colors.orange[100],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_satisfied, size: 50, color: Colors.orange),
                Text('Moderate Stress', style: TextStyle(fontSize: 24)),
                Text('Your stress level is moderate, you should relax a little.',style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    } else if (stressLevel == 4) {
      bodyContent = Center(
        child: Card(
          color: Colors.red[100],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_very_dissatisfied, size: 50, color: Colors.pink),
                Text('High Stress', style: TextStyle(fontSize: 24)),
                Text('Your stress level is high, have you tried meditation?',style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
      } else if (stressLevel == 5) {
      bodyContent = Center(
        child: Card(
          color: Colors.red[100],
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_very_dissatisfied, size: 50, color: Colors.red),
                Text('Very High Stress', style: TextStyle(fontSize: 24)),
                Text('Your stress level is very high, try to reduce your work-load and seek support if you need it<3',style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    } else {
      bodyContent = Center(
        child: Card(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.help_outline, size: 50, color: Colors.grey),
                Text('Unknown Stress Level, syncronize the app', style: TextStyle(fontSize: 22)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 212, 239, 1),
      appBar: AppBar(
        title: Text('Stress Page'),
        backgroundColor: const Color.fromRGBO(232, 212, 239, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bodyContent,
      ),
    );
  }
}

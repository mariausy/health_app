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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_very_satisfied, size: 50, color: Colors.green),
                Text('Low Stress', style: TextStyle(fontSize: 24)),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
    } else if (stressLevel == 3) {
      bodyContent = Center(
        child: Card(
          color: Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sentiment_very_dissatisfied, size: 50, color: Colors.red),
                Text('High Stress', style: TextStyle(fontSize: 24)),
                Text('Your stress level is very high, have you tried meditation?',style: TextStyle(fontSize: 18)),
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
                Text('Unknown Stress Level', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Stress Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bodyContent,
      ),
    );
  }
}

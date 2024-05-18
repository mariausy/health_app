import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:moder8/providers/data_provider.dart';
import 'package:moder8/services/impact.dart';
import 'package:moder8/widgets/line_plot.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // A list of quotes
  final List<String> quotes = [
    "The best way to predict the future is to create it.",
    "You only live once, but if you do it right, once is enough.",
    "To live is the rarest thing in the world. Most people exist, that is all.",
    "Think like a proton, always positiv",
    "Life is like riding a bicycle. To keep your balance you must keep moving. - Elbert Einstein"
  ];

  // Creating a function to show the dialog
  void _showQuoteDialog(BuildContext context) {
    final random = Random();
    final quote = quotes[random.nextInt(quotes.length)];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                quote,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<DataProvider>(builder: (context, data, child) {
              if (data.stepData.isEmpty) {
                return Text('Nothing to display');
              } else {
                return StepDataPlot(stepData: data.stepData);
              }
            }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await ImpactService.authorize();
                final message =
                    result == 200 ? 'Request successful' : 'Request failed';
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              },
              child: Text('Authorize app'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false)
                    .fetchStepData('2023-05-13');
              },
              child: Text('Fetch data'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<DataProvider>(context, listen: false).clearData();
              },
              child: Text('Clear data'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: 'Quote app',
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 241, 153, 182),
              child: Icon(Icons.bookmark_add),
              onPressed: () {
                _showQuoteDialog(context);
              },
            ),
          ),
          SizedBox(height: 8),
          Text('Quote', style: TextStyle(fontSize: 12)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Emergency calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add bottle',
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moder8/models/stress_level.dart';
import 'package:moder8/models/heartdata.dart';
import 'package:provider/provider.dart';
import 'package:moder8/providers/data_provider.dart';
import 'package:moder8/services/impact.dart';
import 'package:moder8/widgets/line_plot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moder8/screens/loginpage.dart';
import 'package:intl/intl.dart';
import 'package:moder8/screens/quotes.dart';
import 'package:moder8/models/stepdata.dart';
import 'package:moder8/models/sleepdata.dart';
import 'package:moder8/screens/stress_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int alcoholUnits = 0; //variable to store abounts of alohol units
  int stessLevelNumber = 1;

  @override
  void initState() {
    super.initState();
    _loadAlcoholUnits(); // Load alcohol units count when app starts
  }

  void _loadAlcoholUnits() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final count = sharedPreferences.getInt('alcoholUnits') ?? 0;
    setState(() {
      alcoholUnits = count;
    });
  }

  void _incrementAlcoholUnits() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final newCount = alcoholUnits + 1;
    sharedPreferences.setInt('alcoholUnits', newCount);
    setState(() {
      alcoholUnits = newCount;
    });
  }

  void _clearAlcoholUnits() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('alcoholUnits', 0);
    setState(() {
      alcoholUnits = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 212, 239, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(232, 212, 239, 1),
        title: const Row(
          children: [
            Icon(Icons.wine_bar_outlined),
            Text(
              'Moder8',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Clear data
                  Provider.of<DataProvider>(context, listen: false).clearData();

                  // Authorize
                  final result = await ImpactService.authorize();
                  final message =
                      result == 200 ? 'Request successful' : 'Request failed';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));

                  // Fetch data
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchHeartData(DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(const Duration(days: 1))));
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchStepData(DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(const Duration(days: 1))));
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchSleepData(DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(const Duration(days: 1))));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sync),
                    Text('Synchronize'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StressPage(stressLevel: stessLevelNumber),
                  ),
                );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_outline),
                    Text('Stress'),
                  ],
                ),
              ),
              Consumer<DataProvider>(builder: (context, data, child) {
                if (data.heartData.length == 0) {
                  return Text('No heart rate data available');
                } //if
                else {
                  return HeartDataPlot(heartData: data.heartData);
                } //else
              }),
              SizedBox(
                height: 10,
              ),
              
              Consumer<DataProvider>(builder: (context, data, child) {
                if (data.heartData.length == 0) {
                  return Text('');
                }//if
                else {
                  StressLevel stressLevel = StressLevel(heartData: data.heartData);
                  String stressLevelText = stressLevel.calculateStressLevel();
                  stessLevelNumber = stressLevel.getstressLevels();
                  return Text("Stress Level: $stressLevelText");
                }//else
              }),
              Consumer<DataProvider>(builder: (context, data, child) {
                if (data.stepData.length == 0 || data.sleepData.length == 0) {
                  return Text('No data available for daily goals');
                } //if
                else {
                  return DailyCircle(
                      stepData: data.stepData, sleepData: data.sleepData);
                } //else
              }),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Provider.of<DataProvider>(context, listen: false).clearData();
                _toLoginPage(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Emergency calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add),
            label: 'Quote',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.add_circle),
                if (alcoholUnits > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$alcoholUnits',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Add bottle',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              showCard(context, 'Emergency Calls', 'Italy: 112');
              break;
            case 1:
              showQuoteDialog(context);
              break;
            case 2:
              //Want to counts alcohol units
              _incrementAlcoholUnits();
              break;
            default:
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearAlcoholUnits,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete), // Icon displayed above the text
            SizedBox(height: 4), // Spacer between icon and text
            Text('Clear'), // Text displayed under the icon
          ],
        ),
      ),
    );
  }

  // Function to increment alcohol units count
  // void _incrementAlcoholUnits() {
  // setState(() {
  //   alcoholUnits++;
  // });
  // Optionally, you can show a notification or perform any other action here
  // }
}

void _toLoginPage(BuildContext context) async {
  //Get the instance and remove isUserLogged flag from shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.remove('isUserLogged');

  //Pop the drawer first
  Navigator.pop(context);
  //Then pop the HomePage
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
} //_toCalendarPage


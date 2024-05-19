import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moder8/providers/data_provider.dart';
import 'package:moder8/services/impact.dart';
import 'package:moder8/widgets/line_plot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moder8/screens/loginpage.dart';
import 'package:moder8/screens/quotes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<DataProvider>(builder: (context, data, child) {
              if (data.heartData.length == 0) {
                return Text('Nothing to display');
              } //if
              else {
                return HeartDataPlot(heartData: data.heartData);
              } //else
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
                child: Text('Authorize app')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchHeartData('2023-05-13');
                },
                child: Text('Fetch data')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<DataProvider>(context, listen: false).clearData();
                },
                child: Text('Clear data')),
          ],
        ),
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
              onTap: () => _toLoginPage(context),
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
                showQuoteDialog(context);
              },
            ),
          ),
          SizedBox(height: 8),
          Text('Quote', style: TextStyle(fontSize: 12)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              showCard(
                  context, 'Emergency Calls', 'Content for emergency calls');
              break;
            case 1:
              showQuoteDialog(context);
              break;
            case 2:
              showCard(context, 'Add Bottle', 'Content for adding a bottle');
              break;
          }
        },
      ),
    );
  }
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

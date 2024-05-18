import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moder8/providers/data_provider.dart';
import 'package:moder8/services/impact.dart';
import 'package:moder8/widgets/line_plot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moder8/screens/loginpage.dart';
// import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: ListView(
        children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<DataProvider>(builder: (context, data, child) {
              if (data.heartData.length == 0) {
                return Text('Nothing to display');
              }//if
              else {
                return HeartDataPlot(heartData: data.heartData);
              }//else
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
                child: Text('Authorize app')
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchHeartData('2023-05-13');
                      //DateFormat('yyyy-MM-dd').format(DateTime.now())
                  Provider.of<DataProvider>(context, listen: false)
                      .fetchStepData('2023-05-13');
                },
                child: Text('Fetch data')
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<DataProvider>(context, listen: false).clearData();
                },
                child: Text('Clear data')
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<DataProvider>(builder: (context, data, child) {
              if (data.stepData.length == 0) {
                return Text('Nothing to display');
              }//if
              else {
                return StepDataCircle(stepData: data.stepData);
              }//else
            }),
          ],
        ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),)
    );
  } //build
} //HomePage

void _toLoginPage(BuildContext context) async{
    //Get the instance and remove isUserLogged flag from shared preferences 
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('isUserLogged');

    //Pop the drawer first 
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }//_toCalendarPage 
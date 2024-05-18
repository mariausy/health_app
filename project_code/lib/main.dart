import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_code/providers/data_provider.dart';
import 'package:project_code/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_code/screens/loginpage.dart';

void main() {
  runApp(MyApp());
} //main

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Now the home becomes a FutureBuilder: we need to wait for the instance of SharedPreferences
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          //If the instance is ready...
          if (snapshot.hasData) {
            //...get the instance
            final sharedPreferences = snapshot.data!;
            //Check if the flag isUserLogged exist...
            if (sharedPreferences.getBool('isUserLogged') != null) {
              //..if so, go directly to HomePage
              return ChangeNotifierProvider(
                create: (context) => DataProvider(),
                child: HomePage()
            );
            } //if
            else {
              //...otherwise go to LoginPage
              return LoginPage();
            } //else
          } //if
          else {
            //While the instance of SharedPreferences is loading, just show a CircularProgress indicator in the Center
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } //else
        },
      ),
    );
  } //build
}//MyApp
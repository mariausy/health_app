import 'package:flutter/material.dart';

import 'package:moder8/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:moder8/providers/data_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}//LoginPage

class _LoginPageState extends State<LoginPage> {

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: 
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async{
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => DataProvider(),
                      child: HomePage(),
                    ),
                  ),
                  );
                  // Navigator.pushReplacement(
                  //       context, MaterialPageRoute(builder: (_) => HomePage()));

                  // //Check user's credentials...
                  // if(userController.text == 'Jpefaq6m58' && passwordController.text == '5TrNgP5Wd'){
                  //   //...if they are correct get the instance of SharedPreferences
                  //   final sharedPreferences = await SharedPreferences.getInstance();
                  //   //...and set the isUserLogged flag
                  //   await sharedPreferences.setBool('isUserLogged', true);

                  //   //Finally, navigate to HomePage
                  //   Navigator.pushReplacement(
                  //       context, MaterialPageRoute(builder: (_) => HomePage()));
                  // }//if
                  // else{
                  //   //If the credentials are not correct, say it!
                  //   ScaffoldMessenger.of(context)
                  //   ..removeCurrentSnackBar()
                  //   ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                  // }//else
                },
                child: Text(
                  'Login',
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }//build
}//_LoginPageState
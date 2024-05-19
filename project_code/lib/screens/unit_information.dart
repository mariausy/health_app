import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moder8/screens/loginpage.dart';
import 'package:moder8/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:moder8/providers/data_provider.dart';

// A list of quotes
final List<String> effects = [
  "You are sober. This is the healthiest state for your body. Keep it up!",
  "After this many units, you might start feeling lightly affected. Drink responsibly and enjoy the moment.",
  "After this many units, you might start feeling lightly affected. Remember, moderation is key.",
  "Be aware, this amount of alcohol can make you more uncritical and risk-averse. Remember to drink responsibly.",
  "Be aware, this amount of alcohol can make you more uncritical and risk-averse. Stay mindful of your limits.",
  "Stay careful. This amount can affect your balance and coordination. Drink responsibly.",
  "Stay careful. This amount can affect your balance and coordination. Remember, safety first.",
  "Your memory might start to be affected by this amount of alcohol. Keep track of your intake.",
  "Your memory might start to be affected by this amount of alcohol. Remember, moderation is crucial.",
  "Please be careful. Listen to your body and know when it's time to stop."
];

class UnitInformationPage extends StatefulWidget {
  UnitInformationPage({Key? key}) : super(key: key);

  @override
  _UnitInformationPage createState() => _UnitInformationPage();
}

class _UnitInformationPage extends State<UnitInformationPage> {
  int alcoholUnits = 0; //variable to store abounts of alohol units
  String effectText = "";

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
    if (alcoholUnits < effects.length) {
      effectText = effects[alcoholUnits];
    } else {
      effectText = effects.last;
    }
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
            Text('Moder8 Unit information page',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),), 
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ), 
            Text('You are now at $alcoholUnits number of units'),
            const SizedBox(
              height: 50,
            ),  
            Text(effectText),
            const SizedBox(
              height: 50,
            ),
            const Icon(Icons.wine_bar_outlined, size: 150)          
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
              title: Text('Homepage'),
              onTap: () async {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => DataProvider(),
                      child: HomePage(),
                    ),
                  ),
                  );
                },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _toLoginPage(context);
              },
            ),
          ],
        ),
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
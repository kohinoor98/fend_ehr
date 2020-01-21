import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fend_ehr/Screens/EHRScreen/EHRScreen.dart';
import 'package:fend_ehr/Screens/PatientEHR.dart';
import 'package:fend_ehr/Screens/Profile.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: BottomNavBar() //AppointmentScreen(),
        );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.list, size: 35),
          Icon(Icons.call_split, size: 35),
          Icon(Icons.perm_identity, size: 35),
        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOutSine,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_page),
      ),
    );
  }
}

List<Widget> _widgetOptions = <Widget>[
  EHRScreen(),
  PatientEHR(),
  ProfilePage(),
];

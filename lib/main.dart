import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fend_ehr/Screens/EHRScreen/EHRScreen.dart';
import 'package:fend_ehr/Screens/PatientEHR.dart';
import 'package:fend_ehr/Screens/Profile.dart';
import 'package:fend_ehr/Screens/SignUp/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';

import 'Screens/SIgnIn/register_button.dart';
import 'Screens/SIgnIn/signin_button.dart';
import 'Screens/SIgnIn/teddy_controller.dart';
import 'Screens/SIgnIn/tracking_text_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: LoginPage(
          title: 'Login Page'), //BottomNavBar() //AppointmentScreen(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TeddyController _teddyController;
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
          child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.0, 1.0],
                colors: [
                  Color(0xffacb6e5).withOpacity(1),
                  // Color.fromRGBO(219, 243, 250, 1.0),
                  // Color.fromRGBO(183, 233, 247, 1.0),
                  // Color.fromRGBO(146, 223, 243, 1.0),
                  Color(0xff86fde8).withOpacity(1),

                  // Color(0xff5433FF).withOpacity(1),
                  // Color(0xff20BDFF).withOpacity(1),
                ],
              ),
            ),
          )),
          Positioned.fill(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 200,
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: FlareActor(
                            "assets/Teddy.flr",
                            shouldClip: false,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.contain,
                            controller: _teddyController,
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Form(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TrackingTextInput(
                                  label: "Phone Number",
                                  hint: "What's your phone number?",
                                  onCaretMoved: (Offset caret) {
                                    _teddyController.lookAt(caret);
                                  },
                                  onTextChanged: (String value) {
                                    _teddyController.setPassword(value);
                                  },
                                ),
                                TrackingTextInput(
                                  label: "Password",
                                  hint: "Try 'bears'...",
                                  isObscured: true,
                                  onCaretMoved: (Offset caret) {
                                    _teddyController.coverEyes(caret != null);
                                    _teddyController.lookAt(null);
                                  },
                                  onTextChanged: (String value) {
                                    _teddyController.setPassword(value);
                                  },
                                ),
                                SigninButton(
                                    child: Text("Sign In",
                                        style: TextStyle(
                                            fontFamily: "RobotoMedium",
                                            fontSize: 16,
                                            color: Colors.white)),
                                    onPressed: () {
                                      _teddyController.submitPassword(context);
                                    }),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => null
                                                      // SignupPage()
                                                      ),
                                            ); //To go to Forgot Password page
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Color(0XFF1DC5A3),
                                                fontSize: 16.0,
                                                fontFamily: 'RobotoMedium',
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Not Yet Registered?',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMedium',
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(width: 5.0),
                                    RegisterButton(
                                        child: Text("Register",
                                            style: TextStyle(
                                                fontFamily: "RobotoMedium",
                                                fontSize: 16,
                                                color: Colors.white)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => 
                                                SignupPage()
                                                ),
                                          ); //To go to signup page
                                        }),
                                  ],
                                ),
                              ],
                            )),
                          )),
                    ])),
          ),
        ],
      )),
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

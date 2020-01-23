import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart'; //To go to login page

/*----------------- SIGN UP PAGE ------------------------*/

//Global variables for email and password validation
String _email;
String _password1;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller =
      new TextEditingController(); //controller for re enter password
  final TextEditingController _passcontroller =
      new TextEditingController(); //controller to get password

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(260.0, 115.0, 0.0, 0.0),
                        child: Text(
                          '.',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff357DED)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail, //Email validation
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF357DED)))),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _passcontroller,
                          validator: (value) => //Password validation
                              value.isEmpty ? 'Password cannot be empty' : null,
                          onSaved: (value) => _password1 = value,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff357DED)))),
                          obscureText: true,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _controller,
                          validator:
                              _validatePassword, //Re enter password validation
                          decoration: InputDecoration(
                              labelText: 'RE-ENTER PASSWORD ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff357DED)))),
                          obscureText: true,
                        ),
                        SizedBox(height: 50.0),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              signUp(); //If validation done then sign up with firebase on signup click
                            }
                          },
                          child: Container(
                              height: 50.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(30.0),
                                shadowColor: Color(0xff357DED),
                                color: Color(0xff357DED),
                                elevation: 7.0,
                                child: Center(
                                  child: Text(
                                    'SIGNUP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 50.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pop(); //To go to login page on go back
                              },
                              child: Center(
                                child: Text('Go Back',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
        ));
  }

//Re enter password validation
  String _validatePassword(String value) {
    print(_password1);
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    } else if (value.length < 6) {
      _controller.clear();
      return 'Password\'s length should be greater than 6';
    } else if (value == _passcontroller.text) {
      return null;
    } else {
      _controller.clear();
      print(_passcontroller.text);
      print(value);

      return 'Passwords do not not match';
    }
  }

  String validateEmail(String value) {
    // Pattern pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    String pattern = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  //To sign up using firebase
  Future<void> signUp() async {
    var alert = new CupertinoAlertDialog(
      title: new Text("Alert"),
      content: new Text("Error has occured"),
      actions: <Widget>[
        new CupertinoDialogAction(
            child: const Text('OK'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'OK');
            }),
      ],
    );

    final formState = _formKey.currentState;
    //validate
    print('insidesignup');
    if (formState.validate()) {
      formState.save();

      // FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: _email, password: _password1)
      //     .then((user) {
      //   Fluttertoast.showToast(
      //       msg: "Signing Up...",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIos: 1,
      //       backgroundColor: Colors.black26,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               LoginPage())); //To go to login page on successful sign up
      // }).catchError((error) {
      //   if (error.code == 'exception') {
      //     Fluttertoast.showToast(
      //         msg: "Email Exists! Reset Password using Forgot Password",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.BOTTOM,
      //         timeInSecForIos: 1,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //     print(error.details);

      //showDialog(context: context, child: alert);
      // code, message, details

      //       }
      //     });
    }
  }
}

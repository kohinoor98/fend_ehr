import 'package:fend_ehr/Logic/EHRManager.dart';
import 'package:fend_ehr/Screens/EHRDetailScreen/EHRDetailScreen.dart';
import 'package:fend_ehr/WidgetComponents/EHRCard.dart';
import 'package:fend_ehr/WidgetComponents/SlidingCard.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../sizeConfig.dart';

class EHRScreen extends StatefulWidget {
  @override
  _EHRScreenState createState() => _EHRScreenState();
}

class _EHRScreenState extends State<EHRScreen> {
  bool isFirstTime = false;
  bool isLoading = true;
  List<Widget> topHeader;
  List<Widget> currentAppointment;
  List<Widget> midHeader;
  List<Widget> futureAppointment;
  List<Widget> finalList;

  @override
  void initState() {
    super.initState();
    topHeader = [];
    currentAppointment = [];
    midHeader = [];
    futureAppointment = [];
    finalList = [];

    EHRManager.generateEHRList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (isFirstTime == false) {
      initiateList();
      isFirstTime = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xffF3F6FF).withOpacity(0.134),
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.black54,
          size: SizeConfig.horizontalBloc * 8,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync,
              color: Colors.black54,
              size: SizeConfig.horizontalBloc * 8,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              topHeader..clear();
              currentAppointment..clear();
              midHeader..clear();
              futureAppointment.clear();
              finalList..clear();
              EHRManager.ehrList.clear();
              //print(finalList.length);
              EHRManager.generateEHRList();
              initiateList();

              Future.delayed(Duration(milliseconds: 375), () {
                isLoading = false;
                setState(() {});
              });
            },
          )
        ],
      ),
      body: isLoading
          ? SizedBox()
          : Container(
              color: Color(0xffF3F6FF).withOpacity(0.134),
              child: AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: finalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (isFirstTime == false) {
                      setState(() {});
                    }

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: -20,
                        child: FadeInAnimation(child: finalList[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  ///I use this function to make an aggragated list
  ///this list will then be feeded into the listview"builder
  ///IMPORTANT : Using this function i understood
  ///that gicving keys to child widget is important if you are
  ///panning on rebuilding them dynamically by adding custom parameters
  Future<bool> initiateList() async {
    //First we work on the header of the list

    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 15),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 5,
          //color: Colors.pink,
          child: Text(
            'Dr. @emilecode',
            style: TextStyle(
              fontSize: SizeConfig.horizontalBloc * 9.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );

    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 9, top: 7),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 3,
          //color: Colors.pink,
          child: Text(
            'Priority EHR Requests',
            style: TextStyle(
                fontSize: SizeConfig.horizontalBloc * 6, color: Colors.black45),
          ),
        ),
      ),
    );

    //now we create the card comming from the appointment manager
    for (var anElement in EHRManager.ehrList) {
      // if (anElement.isFuture == false) {
      ///not obliged to be this way , can directly be passed at time of initialization
      SlidingCardController aController = new SlidingCardController();
      print('adding big card');
      currentAppointment.add(Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: EHRCard(
          onCardTapped: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: EHRDetailScreen(
                      ehrData: anElement,
                    )));
          },
          key: Key(Random().nextInt(4000).toString()),
          slidingCardController: aController,
          ehrData: anElement,
        ),
      )));
      // } else {
      //   print('adding mini card');
      //   futureAppointment.add(Center(
      //       child: MiniEHRCard(
      //     onCardTapped: () {
      //       Navigator.push(
      //           context,
      //           PageTransition(
      //               type: PageTransitionType.fade,
      //               child: EHRDetailScreen(
      //                 ehrData: anElement,
      //               )));
      //     },
      //     ehrData: anElement,
      //   )));
      // }
    }
    // midHeader.add(
    //   Padding(
    //     padding: const EdgeInsets.only(top: 10.0, bottom: 9, left: 20),
    //     child: Container(
    //       width: SizeConfig.safeBlockHorizontal * 90,
    //       height: SizeConfig.verticalBloc * 3,
    //       //color: Colors.pink,
    //       child: Text(
    //         'Non-priority EHR Requests',
    //         style: TextStyle(
    //             fontSize: SizeConfig.horizontalBloc * 5, color: Colors.black45),
    //       ),
    //     ),
    //   ),
    // );

    // We create the final list that will be passed to the
    //listView.builder
    finalList.addAll(topHeader);
    finalList.addAll(currentAppointment);
    // finalList.addAll(midHeader);
    // finalList.addAll(futureAppointment);
    if (isFirstTime == false) {
      isLoading = false;
      setState(() {});
    }
    setState(() {});
    return true;
  }
}

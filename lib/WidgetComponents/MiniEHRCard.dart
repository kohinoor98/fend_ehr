import 'package:cached_network_image/cached_network_image.dart';
import 'package:fend_ehr/model/EHR.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../sizeConfig.dart';

class MiniEHRCard extends StatelessWidget {
  final EHR ehrData;
  final Function onCardTapped;
  const MiniEHRCard({
    @required this.ehrData,
    @required this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );

    return GestureDetector(
      onTap: () {
        print('Mini ehr Card tapped');
        onCardTapped();
      },
      child: Card(
        elevation: 0.3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          width: SizeConfig.horizontalBloc * 90,
          height: SizeConfig.verticalBloc * 8.7,
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(ehrData.imgLink),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(20)),
                        height: SizeConfig.safeBlockVertical * 8,
                        width: SizeConfig.safeBlockHorizontal * 15,
                      ),
                      Positioned(
                        right: -3,
                        bottom: -0.5,
                        child: Container(
                          width: SizeConfig.safeBlockHorizontal * 4.5,
                          height: SizeConfig.safeBlockHorizontal * 4.5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                              color: Color(0xff5EFF38)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.safeBlockVertical * 3,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.yellow,
                        child: Text(
                          ehrData.patienSurname + ' ' + ehrData.patientName,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical * 3,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.pink,
                        child: Text(
                          ehrData.appoitmentDate +
                              ', ' +
                              ehrData.appoitmentTime,
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    color: Colors.black54,
                    iconSize: SizeConfig.safeBlockHorizontal * 7,
                    onPressed: () {
                      print('Cloud Download Tapped');
                      Alert(
                        context: context,
                        style: alertStyle,
                        type: AlertType.info,
                        title: "Download All Items",
                        desc: "Do you want to download all E-Hospital Records?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Yes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              print('YES pressed; dialog box');
                              Navigator.pop(context);
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                            radius: BorderRadius.circular(0.0),
                          ),
                          DialogButton(
                            child: Text(
                              "No",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              print('NO pressed; dialog box');
                              Navigator.pop(context);
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                            radius: BorderRadius.circular(0.0),
                          ),
                        ],
                      ).show();
                    },
                    icon: Icon(Icons.cloud_download),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

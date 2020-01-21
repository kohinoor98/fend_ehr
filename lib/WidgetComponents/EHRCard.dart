import 'package:fend_ehr/model/EHR.dart';
import 'package:fend_ehr/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'EHRBackCard.dart';
import 'EHRFrontCard.dart';
import 'SlidingCard.dart';


///This is the main Appointment card 
///it regroups the AppointmentFrontCard 
///and AppointmentBacktCard together 
///using my future dart package ''SlidingCard''
class EHRCard extends StatelessWidget {
  const EHRCard({
    Key key,
    this.slidingCardController ,@required this.ehrData, @required this.onCardTapped
  }) : super(key: key);
  final EHR ehrData;
  final  SlidingCardController slidingCardController;
  final Function onCardTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('Well the card was tapped');
        onCardTapped();
      },
          child: SlidingCard(
        slimeCardElevation: 0.5,
       // slidingAnimationReverseCurve: Curves.bounceInOut,
        cardsGap: SizeConfig.safeBlockVertical,
        controller: slidingCardController,
        slidingCardWidth: SizeConfig.horizontalBloc * 90,
        visibleCardHeight: SizeConfig.safeBlockVertical * 27,
        hiddenCardHeight: SizeConfig.safeBlockVertical * 15,
        frontCardWidget: EHRFrontCard(
          imgLink: ehrData.imgLink,
          patienName: ehrData.patientName,
          patienSurname: ehrData.patienSurname,
          appointmentDate: ehrData.appoitmentDate,
          appointmentTime: ehrData.appoitmentTime,
          onInfoTapped: () {
            print('info pressed');
            slidingCardController.expandCard();
          },
          onDecline: () {
            print('Declined');
          },
          onAccep: () {
            print('Accepted');
          },
          onRedCloseButtonTapped: (){
            slidingCardController.collapseCard();
          },
        ),
        backCardWidget:EHRBackCard(
          onPhoneTapped: (){print('Phone tapped');},
          patientComment: ehrData.appoitmentComment
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const SigninButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xff5433FF).withOpacity(0.75),
              Color(0xff20BDFF).withOpacity(0.75),

              // Color(0xffacb6e5).withOpacity(1),
              // Color.fromRGBO(219, 243, 250, 1.0),
              // Color.fromRGBO(183, 233, 247, 1.0),
              // Color.fromRGBO(146, 223, 243, 1.0),
              // Color(0xff86fde8).withOpacity(1),

              // Color.fromRGBO(115, 82, 135, 1.0)
            ],
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

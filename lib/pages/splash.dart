import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:cup_and_soup/services/auth.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _signInUser() {
    authService.signIn(context);
  }

  @override
  void initState() {
    super.initState();
    _signInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        offset: Offset(-250, 200),
        child: Transform.rotate(
          angle: -math.pi / 2.0,
          child: Transform.scale(
            scale: 2,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
        ),
      ),
    );
  }
}

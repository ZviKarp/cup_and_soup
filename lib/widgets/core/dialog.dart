import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  DialogWidget({
    @required this.child,
    this.backgroundColor = const Color(0xffffffff),
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(16.0),
    this.blurColor = const Color(0x10ffffff),
    this.shadowColor = const Color(0xfff9E9E9E),
  });

  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color shadowColor;
  final Color blurColor;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blurColor,
      body: SafeArea(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                new BoxShadow(
                  color: shadowColor,
                  blurRadius: 20.0,
                )
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 42.0, vertical: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Transform.rotate(
                  angle: -math.pi / 1.0,
                  child: Image.asset(
                    "assets/images/navBar.png",
                    height: 30,
                    alignment: Alignment(0, -1),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                child,
                Image.asset(
                  "assets/images/navBar.png",
                  height: 30,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

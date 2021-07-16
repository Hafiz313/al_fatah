import 'dart:async';

import 'package:flutter/material.dart';

import 'logint_screen.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }


  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('images/bg_image.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(alignment: Alignment.center,
              child: Text("Tattoo", style: TextStyle(fontSize: 50,
                  color: Colors.white,
                  fontFamily: 'Dancing Script',
                  fontWeight: FontWeight.w900)),)
          ],
        ),
      ),


    );
  }
}
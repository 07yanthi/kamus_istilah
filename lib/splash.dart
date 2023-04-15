import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/app/modules/home/views/home_view.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({required Key key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // create db

    Duration duration = Duration(seconds: 3);

    Route route = MaterialPageRoute(builder: (context) => HomeView());

    Timer(duration, () {
      Navigator.pushReplacement(context, route);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.asset(
                  'assets/logo.png',
                  width: double.infinity,
                ),
              ),
              CircularProgressIndicator(
                backgroundColor: Color(0xff4f9b9b),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Harap tunggu...'),
              )
            ],
          )),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //       padding: const EdgeInsets.only(bottom: 50.0),
          //       child: Text('App Version 1.0.0')),
          // ),
        ],
      ),
    );
  }
}

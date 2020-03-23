import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_APP_BAR,
      body: Center(
        child: Image.asset("assets/images/logo.png", height: 100, width: 100,),
      ),
    );
  }
}
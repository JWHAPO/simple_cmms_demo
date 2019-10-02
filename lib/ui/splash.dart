import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/login')); // 2초 뒤에 HomePage로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: null,
        color: Colors.greenAccent,
      ),
    );
  }
}


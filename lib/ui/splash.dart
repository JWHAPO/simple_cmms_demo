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
    Timer(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, '/main')); // 2초 뒤에 HomePage로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash_image.png'),
                      fit: BoxFit.fill)),
            ),
            Text(
              'Cricket Demo',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontFamily: 'NotoSans-bold'),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}

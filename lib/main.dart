import 'package:flutter/material.dart';
import 'package:simple_cmms_demo/ui/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var routes = <String, WidgetBuilder>{
    '/main':(BuildContext context) => MyHomePage(key: Key("mainPage"), title: "Recipe",),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromRGBO(255, 242, 230, 1.0)),
      routes: routes,
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  var _tab1Icon = Icon(Icons.home, color: Colors.blueAccent,);
  var _tab2Icon = Icon(Icons.accessibility, color: Colors.grey,);
  var _tab3Icon = Icon(Icons.account_balance, color: Colors.grey,);
  var _tab4Icon = Icon(Icons.web, color: Colors.grey,);
  var _tab5Icon = Icon(Icons.wallpaper, color: Colors.grey,);

  final List<Widget> _tabChildren = [
    null,
    null,
    null,
    null,
    null
  ];



  @override
  Widget build(BuildContext context) {

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(255, 242, 230, 1.0),
      title: Text(widget.title),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(255, 242, 230, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

          ],
        ),
      ),
    );


    return BottomNavigationBar(

    );

  }
}

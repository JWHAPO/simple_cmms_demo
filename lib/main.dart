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
            IconButton(icon: _tab1Icon, onPressed: (){

            }),
            IconButton(icon: _tab2Icon, onPressed: (){

            }),
            IconButton(icon: _tab3Icon, onPressed: (){

            }),
            IconButton(icon: _tab4Icon, onPressed: (){

            }),
            IconButton(icon: _tab5Icon, onPressed: (){

            })
          ],
        ),
      ),
    );


    return Scaffold(
      appBar: topAppBar,
      backgroundColor: Color.fromRGBO(255, 242, 230, 1.0),
      body: _tabChildren[_currentIndex],
      bottomNavigationBar: makeBottom,
    );
  }

  void onTabTapped(int index){
    setState(() {
      if(index==2){

      }else{
        _currentIndex = index;

        _tab1Icon = Icon(Icons.home, color:Colors.grey);
        _tab2Icon = Icon(Icons.accessibility, color:Colors.grey);
        _tab3Icon = Icon(Icons.account_balance, color:Colors.grey);
        _tab4Icon = Icon(Icons.web, color:Colors.grey);
        _tab5Icon = Icon(Icons.wallpaper, color:Colors.grey);
        switch(_currentIndex){
          case 0:
            _tab1Icon = Icon(Icons.home, color:Colors.blue);
            break;
          case 1:
            _tab2Icon = Icon(Icons.accessibility, color:Colors.blue);
            break;
          case 2:

            break;
          case 3:
            _tab4Icon = Icon(Icons.web, color:Colors.blue);
            break;
          case 4:
            _tab5Icon = Icon(Icons.wallpaper, color:Colors.blue);
            break;
        }
      }
    });
  }
}

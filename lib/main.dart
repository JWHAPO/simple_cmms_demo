import 'package:flutter/material.dart';
import 'package:simple_cmms_demo/ui/splash.dart';
import 'package:simple_cmms_demo/ui/home.dart';
import 'package:simple_cmms_demo/ui/wolist.dart';
import 'package:simple_cmms_demo/ui/eqlist.dart';
import 'package:simple_cmms_demo/ui/chart.dart';
import 'package:simple_cmms_demo/ui/request.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  var routes = <String, WidgetBuilder>{
    '/main':(BuildContext context) => MyHomePage(key: Key("mainPage"), title: "Cricket Demo",),
    'request':(BuildContext context) => RequestPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromRGBO(255, 255, 255, 1.0)),
      routes: routes,
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  var _tab1Icon = Icon(Icons.home, color: Colors.black,);
  var _tab2Icon = Icon(Icons.format_list_numbered, color: Colors.grey,);
  var _tab3Icon = Icon(Icons.add, color: Colors.redAccent,);
  var _tab4Icon = Icon(Icons.business, color: Colors.grey,);
  var _tab5Icon = Icon(Icons.show_chart, color: Colors.grey,);

  final List<Widget> _tabChildren = [
    HomePage(),
    WoListPage(),
    null,
    EqListPage(),
    ChartPage()
  ];



  @override
  Widget build(BuildContext context) {

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      title: Text(widget.title, style: TextStyle(fontFamily: 'NotoSans-bold'),),
    );

    final makeBottom = Container(
      height: 60.0,
      child: BottomAppBar(
        color: Color.fromRGBO(255, 255, 255, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(icon: _tab1Icon, onPressed: (){
              onTabTapped(0);
            }),
            IconButton(icon: _tab2Icon, onPressed: (){
              onTabTapped(1);
            }),
            IconButton(icon: _tab3Icon, onPressed: (){
              onTabTapped(2);
            }),
            IconButton(icon: _tab4Icon, onPressed: (){
              onTabTapped(3);
            }),
            IconButton(icon: _tab5Icon, onPressed: (){
              onTabTapped(4);
            })
          ],
        ),
      ),
    );


    return Scaffold(
      appBar: topAppBar,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: _tabChildren[_currentIndex],
      bottomNavigationBar: makeBottom,
    );
  }

  void onTabTapped(int index){
    setState(() {
      if(index==2){
        Navigator.pushNamed(context, 'request');
      }else{
        _currentIndex = index;

        _tab1Icon = Icon(Icons.home, color:Colors.grey);
        _tab2Icon = Icon(Icons.format_list_numbered, color:Colors.grey);
        _tab3Icon = Icon(Icons.add, color:Colors.redAccent);
        _tab4Icon = Icon(Icons.business, color:Colors.grey);
        _tab5Icon = Icon(Icons.show_chart, color:Colors.grey);
        switch(_currentIndex){
          case 0:
            _tab1Icon = Icon(Icons.home, color:Colors.black);
            widget.title = 'Cricket Demo';
            break;
          case 1:
            _tab2Icon = Icon(Icons.format_list_numbered, color:Colors.black);
            widget.title = 'Work Order';
            break;
          case 3:
            _tab4Icon = Icon(Icons.business, color:Colors.black);
            widget.title = 'Equipment';
            break;
          case 4:
            _tab5Icon = Icon(Icons.show_chart, color:Colors.black);
            widget.title = 'Chart';
            break;
        }
      }
    });
  }
}

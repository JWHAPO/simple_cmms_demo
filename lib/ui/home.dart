import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text('10월 ', style: TextStyle(fontSize: 22, color:Colors.blueAccent, fontFamily: 'NotoSans-bold'),),
                      Text('보전날씨 ', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(child: Text('더 보기', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans-bold'),),
                  onTap: (){
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('더 보기 버튼 클릭 ')));
                  },),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/status_a.png'),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('이 달의 고장 Top3 설비 ', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(child: Text('더 보기', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'NotoSans-bold'),),
                    onTap: (){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('더 보기 버튼 클릭 ')));
                    },),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget monthCondition(){
    return Stack(
      children: <Widget>[

      ],
    );
  }
}

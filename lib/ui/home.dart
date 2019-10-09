import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> breakdownEquip3Images = [
    'assets/images/eq1.jpg',
    'assets/images/eq2.jpg',
    'assets/images/eq3.jpg'
  ];
  final List<String> breakdownEquip3Names = [
    'BOPP오버랩핑기',
    '자동결속기',
    '천공/제본기'
  ];
  final List<String> breakdownEquip3Desc = [
    '고장건수: 3건, 개선건수: 2건, 설비정지:2건, 기계중지:1건',
    '고장건수: 2건, 개선건수: 1건, 설비정지:1건, 기계중지:1건',
    '고장건수: 1건, 개선건수: 1건, 설비정지:0건, 기계중지:1건',
  ];

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
            monthCondition(),
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
            breakdownTop3(),
            Container(
              height: 30,
              color: Colors.amberAccent,
            )
          ],
        ),
      )
    );
  }

  Widget monthCondition(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.amberAccent,
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.wb_sunny, color: Colors.blueAccent, size: 60,),
          SizedBox(width: 20.0,),
          Text('Status is Good', style: TextStyle(fontSize: 26, color:Colors.blueAccent, fontFamily: 'NotoSans-bold'),)
        ],
      ),
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  fit: BoxFit.fill,
//                  image: AssetImage('assets/images/status_a.png'),
//                ),
//              ),
    );
  }

  Widget breakdownTop3(){
    return Container(
      height: MediaQuery.of(context).size.height*0.26,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: breakdownEquip3Images.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(breakdownEquip3Images[index],width: MediaQuery.of(context).size.height*0.18, height: MediaQuery.of(context).size.height*0.18,),
                ),
                SizedBox(
                  child: Text(breakdownEquip3Names[index], style: TextStyle(fontSize: 12, fontFamily: 'NotoSans-bold'),),
                  width: MediaQuery.of(context).size.height*0.18,
                ),
                SizedBox(
                  child: Text(breakdownEquip3Desc[index], style: TextStyle(fontSize: 10, fontFamily: 'NotoSans-thin'),),
                  width: MediaQuery.of(context).size.height*0.18,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

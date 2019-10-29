import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final List<String> myWorkImages = [
    'assets/images/bm3.jpg',
    'assets/images/bm4.jpg',
    'assets/images/bm5.jpg'
  ];
  final List<String> myWorkEquip = [
    'BOPP오버랩핑기',
    '자동결속기',
    '천공/제본기'
  ];
  final List<String> myWorkDesc = [
    '이 것좀 고쳐주십시오 보전팀님들1',
    '이 것좀 고쳐주십시오 보전팀님들2',
    '이 것좀 고쳐주십시오 보전팀님들3'
  ];

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
  final List<String> breakdownEquip3Location = [
    '경기공장 > 1라인 > 포장 1실',
    '경기공장 > 2라인 > 배합 1실 > 1번 창구 > 1번 줄',
    '경기공장 > 4라인 > 포장 1실'
  ];


  final List<String> inCompletedWorkImage = [
    'assets/images/bm1.jpg',
    'assets/images/bm2.jpg',
    'assets/images/bm3.jpg',
    'assets/images/bm4.jpg',
    'assets/images/bm5.jpg'
  ];
  final List<String> inCompletedWorkEquip = [
    'BOPP오버랩핑기',
    '자동결속기',
    '천공/제본기',
    '천공/제본기',
    '천공/제본기'
  ];
  final List<String> inCompletedWorkDesc = [
    '고장났습니다. 부품교체해주세요',
    '고쳐주세요 고쳐주세요 고쳐줘요 고쳐줘요',
    '너무 낡았습니다. 새로 사야할 것 같은 생각이 들고있어요.',
    '너무 낡았습니다. 새로 사야할 것 같은 생각이 들고있어요.',
    '너무 낡았습니다. 새로 사야할 것 같은 생각이 들고있어요.'
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
                  child: Text('이 달의 고장 Top3 설비', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
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
            breakdownTop3Equip(),
            SizedBox(height: 10.0,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('나의 작업', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
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
            myWork3(),
            SizedBox(height: 10.0,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('미 해결 고장작업', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
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
            inCompletedWork5(),
            SizedBox(height: 10.0,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('관심이 필요합니다.', style: TextStyle(fontSize: 16, fontFamily: 'NotoSans-bold'),)
                ),
              ],
            ),
            needsAttentionEquip(),
            SizedBox(height: 10.0,),
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

  Widget myWork3(){
    return Container(
      height: MediaQuery.of(context).size.height*0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myWorkImages.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('항목 클릭함 ')));
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(myWorkImages[index],width: MediaQuery.of(context).size.height*0.18, height: MediaQuery.of(context).size.height*0.18,fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    child: Text(myWorkEquip[index], style: TextStyle(fontSize: 12, fontFamily: 'NotoSans-bold'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                  SizedBox(
                    child: Text(myWorkDesc[index], style: TextStyle(fontSize: 10, fontFamily: 'NotoSans-thin'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget breakdownTop3Equip(){
    return Container(
      height: MediaQuery.of(context).size.height*0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: breakdownEquip3Images.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('항목 클릭함 ')));
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(breakdownEquip3Images[index],width: MediaQuery.of(context).size.height*0.18, height: MediaQuery.of(context).size.height*0.18,fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    child: Text(breakdownEquip3Names[index], style: TextStyle(fontSize: 12, fontFamily: 'NotoSans-bold'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                  SizedBox(
                    child: Text(breakdownEquip3Location[index], style: TextStyle(fontSize: 10, fontFamily: 'NotoSans-thin'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget inCompletedWork5(){
    return Container(
      height: MediaQuery.of(context).size.height*0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: inCompletedWorkImage.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('항목 클릭함 ')));
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(inCompletedWorkImage[index],width: MediaQuery.of(context).size.height*0.18, height: MediaQuery.of(context).size.height*0.18,fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    child: Text(inCompletedWorkEquip[index], style: TextStyle(fontSize: 12, fontFamily: 'NotoSans-bold'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                  SizedBox(
                    child: Text(inCompletedWorkDesc[index], style: TextStyle(fontSize: 10, fontFamily: 'NotoSans-thin'),),
                    width: MediaQuery.of(context).size.height*0.18,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget needsAttentionEquip(){
    return InkWell(
      onTap: (){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('항목 클릭함 ')));
      },
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                Image.asset(breakdownEquip3Images[1],width: MediaQuery.of(context).size.width * 0.8, height: MediaQuery.of(context).size.width * 0.8,fit: BoxFit.cover,),
                Padding(padding: EdgeInsets.only(left: 3.0, top: 3.0), child: Text(breakdownEquip3Names[1], style: TextStyle(backgroundColor: Colors.grey, fontSize: 18, color: Colors.white, fontFamily: 'NotoSans-bold'),)),
              ],
            )
          )
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class WoListPage extends StatefulWidget {
  @override
  _WoListPageState createState() => _WoListPageState();
}

class _WoListPageState extends State<WoListPage> {


  final List<String> workOrderEquips = [
    '종합배합기',
    'BOPP오버랩핑기',
    '천공제어장비',
    '플레이스테이션4',
    '삼성 투도어 냉장고',
    '맥북프로2019',
    '셀리턴 피부 개선장비',
    '루이비똥 초록가방',
    '삼성 커브드 모니터',
    '맥북프로 2013 13인치'
  ];
  final List<String> workOrderTitles = [
    '고쳐고쳐주세요.1',
    '고쳐고쳐주세요.2',
    '고쳐고쳐주세요.3',
    '고쳐고쳐주세요.4',
    '고쳐고쳐주세요.5',
    '고쳐고쳐주세요.6',
    '고쳐고쳐주세요.7',
    '고쳐고쳐주세요.8',
    '고쳐고쳐주세요.9',
    '고쳐고쳐주세요.10'
  ];

  final List<String> workOrderImages = [
    'assets/images/bm1.jpg',
    'assets/images/bm2.jpg',
    'assets/images/bm3.jpg',
    'assets/images/bm4.jpg',
    'assets/images/bm5.jpg',
    'assets/images/bm1.jpg',
    'assets/images/bm2.jpg',
    'assets/images/bm3.jpg',
    'assets/images/bm4.jpg',
    'assets/images/bm5.jpg'
  ];

  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          searchBox(),
          listView()
        ],
      ),
    );
  }

  Widget searchBox(){
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value){

              },
              controller: searchEditingController,
              style: TextStyle(
                fontFamily: 'NotoSans-thin',
                height: 1.0
              ),
              decoration: InputDecoration(
                  hintText: 'Search Equipment',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  )
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: (){

            },
            child: Icon(Icons.filter_center_focus, size: 30,),
          ),
        ),
      ],
    );
  }

  Widget listView(){
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index){
            return Divider(
              color: Colors.grey,
            );
          },
          shrinkWrap: true,
          itemCount: workOrderTitles.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(workOrderImages[index],width:60.0, height: 60.0, fit: BoxFit.cover,),
              ),
              title: Text(workOrderEquips[index],style: TextStyle(fontFamily: 'NotoSans-bold'),),
              subtitle: Text(workOrderTitles[index],style: TextStyle(fontFamily: 'NotoSans-thin'),),
              onTap: (){

              },
              onLongPress: (){

              },
            );
          }),
    );
  }
}

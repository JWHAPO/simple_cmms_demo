import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class EqListPage extends StatefulWidget {
  @override
  _EqListPageState createState() => _EqListPageState();
}

class _EqListPageState extends State<EqListPage> {

  final List<String> equips = [
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
  final List<String> equipLines = [
    '인천공장 > 1라인 > 배합실',
    '인천공장 > 1라인 > 랩핑실',
    '인천공장 > 3라인 > 제어실',
    '정우방 > 책상위 > 오른편',
    '거실 > 부엌',
    '정우방 > 책상위 > 가운데',
    '안방 > 화장대 > 위쪽',
    '정우방 > 책장 > 위쪽',
    '정우방 > 책상위 > 가운데',
    '정우방 > 책상위 > 가운데'
  ];

  final List<String> equipImages = [
    'assets/images/eq1.jpg',
    'assets/images/eq2.jpg',
    'assets/images/eq3.jpg',
    'assets/images/eq1.jpg',
    'assets/images/eq2.jpg',
    'assets/images/eq3.jpg',
    'assets/images/eq1.jpg',
    'assets/images/eq2.jpg',
    'assets/images/eq3.jpg',
    'assets/images/eq2.jpg'
  ];

  TextEditingController searchEditingController = TextEditingController();
  String _scanBarcode = 'Unknown';


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
              scanBarcode();

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
          itemCount: equips.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(equipImages[index],width:60.0, height: 60.0, fit: BoxFit.cover,),
              ),
              title: Text(equips[index],style: TextStyle(fontFamily: 'NotoSans-bold'),),
              subtitle: Text(equipLines[index],style: TextStyle(fontFamily: 'NotoSans-thin'),),
              onTap: (){

              },
              onLongPress: (){

              },
            );
          }),
    );
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;

    try{
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FF0000', 'Cancel', true, ScanMode.DEFAULT);
      print('barcode:::$barcodeScanRes');
    } on PlatformException{
      barcodeScanRes = 'Failed to get platform version.';
    }

    if(!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      searchEditingController.text = _scanBarcode;
    });
  }
}

import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    //바코드
    //요청 내용
    //타입
    //사진

    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is Request Page',
              style: TextStyle(color: Colors.blue, fontSize: 32),
            ),
            RaisedButton(
                child: Text(
                  'Back!',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                    Container(
                      child: Chip(
                        label: Text('작업형태1',style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.deepPurpleAccent,
                        elevation: 4,
                        shadowColor: Colors.grey[50],
                        padding: EdgeInsets.all(4),
                      ),
                      margin: EdgeInsets.only(left: 12, right: 12,top: 2,bottom: 2),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('작업형태2')),
                      label: Text('Lafayette'),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('작업형태3')),
                      label: Text('Mulligan'),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: Text('작업형태4')),
                      label: Text('Laurens'),
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

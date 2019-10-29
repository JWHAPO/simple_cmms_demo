import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {


  final _titleTextEditingController = TextEditingController();
  FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();;
    _titleFocusNode = FocusNode();

  }

  @override
  void dispose() {
    super.dispose();
    _titleFocusNode.dispose();
  }



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
                }),
            Padding(
              padding: EdgeInsets.only(left: 10.0 , right: 10.0),
              child: TextFormField(
                controller: _titleTextEditingController,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Write equipment name. ',
                  labelText: 'Equipment *',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {


  final _equipmentTextEditingController = TextEditingController();
  final _requestTextEditingController = TextEditingController();

  FocusNode _equipmentFocusNode;
  FocusNode _requestFocusNode;

  String _scanBarcode = 'Unknown';
  File _image;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _equipmentFocusNode = FocusNode();

  }

  @override
  void dispose() {
    super.dispose();
    _equipmentFocusNode.dispose();
  }



  @override
  Widget build(BuildContext context) {
    //바코드
    //요청 내용
    //타입
    //사진

    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          title: Text('Request', style: TextStyle(fontFamily: 'NotoSans-bold'),),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0 , right: 10.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    TextFormField(
                      controller: _equipmentTextEditingController,
                      focusNode: _equipmentFocusNode,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Write equipment name. ',
                        labelText: 'Equipment *',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: InkWell(
                        onTap: (){
                          scanBarcode();
                        },
                        child: Icon(Icons.filter_center_focus, size: 30,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: 120,
                alignment: Alignment.center,
                color: Colors.grey,
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _image == null ? Icon(Icons.add, color: Colors.black,) : Image.file(_image)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  controller: _requestTextEditingController,
                  focusNode: _requestFocusNode,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Write description . ',
                    labelText: 'Request description *',
                    contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0)
                  ),
                ),
              )

            ],
          ),
        ),
      ),
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
      _equipmentTextEditingController.text = _scanBarcode;
    });
  }

}

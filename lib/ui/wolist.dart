import 'package:flutter/material.dart';


class WoListPage extends StatefulWidget {
  @override
  _WoListPageState createState() => _WoListPageState();
}

class _WoListPageState extends State<WoListPage> {
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          searchBox()
        ],
      ),
    );
  }

  Widget searchBox(){
    return Container(
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
              hintText: 'Input Equipment',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none
          ),
        ),
      ),
    );
  }
}

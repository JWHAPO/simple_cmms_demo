import 'package:flutter/material.dart';


class EqDetailPage extends StatefulWidget {
  @override
  _EqDetailPageState createState() => _EqDetailPageState();
}

class _EqDetailPageState extends State<EqDetailPage> {

  final _equipmentTextEditingController = TextEditingController();
  FocusNode _equipmentFocusNode;


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
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _equipmentTextEditingController,
              focusNode: _equipmentFocusNode,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Equipment *',
              ),
            )
          ],
        ),
      ),
    );
  }
}

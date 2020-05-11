import 'package:flutter/material.dart';
import 'package:pixri/src/api/field_api_service.dart';
import 'package:pixri/src/views/fields/field_form.dart';
import 'package:pixri/src/model/entity.dart';


import 'package:pixri/src/views/fields/field_list_view.dart';

class FieldPage extends StatefulWidget {
  @override
  FieldPageStage createState() => FieldPageStage();
  Entity entity;


  FieldPage({this.entity});
}

class FieldPageStage extends State<FieldPage> {
  FieldApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = FieldApiService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Entities", style: TextStyle(color: Colors.white)),
//          actions: <Widget>[
//            IconButton(
//              onPressed: () => Navigator.push(
//                context,
//                MaterialPageRoute(builder: (BuildContext context) => Post_From()),
//              ),
//              icon: Icon(Icons.add, color: Colors.white),
//            )
//          ],
        ),
        // body: FieldListView(),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => FieldForm(entity:  widget.entity)),
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

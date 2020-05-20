import 'package:flutter/material.dart';
import 'package:pixri/src/api/field_api_service.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/views/entity/entity_view.dart';
import 'package:pixri/src/views/fields/field_form.dart';
import 'package:pixri/src/model/entity.dart';

import 'package:pixri/src/views/fields/field_list_view.dart';

class FieldPage extends StatefulWidget {
  @override
  FieldPageStage createState() => FieldPageStage();
  Entity entity;
  Application application;

  FieldPage(this.entity, this.application);
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
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EntityView(widget.entity, widget.application)));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Fields", style: TextStyle(color: Colors.white)),
          ),
          body: FieldListView(widget.entity, widget.application),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FieldForm(widget.entity, widget.application)),
            ),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

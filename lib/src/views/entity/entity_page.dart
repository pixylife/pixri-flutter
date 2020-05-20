import 'package:flutter/material.dart';
import 'package:pixri/src/api/entity_api_service.dart';
import 'package:pixri/src/views/entity/entity_form.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/views/entity/entity_list_view.dart';

class EntityPage extends StatefulWidget {
  @override
  EntityPageStage createState() => EntityPageStage();
  Application application;

  EntityPage(this.application);
}

class EntityPageStage extends State<EntityPage> {
  EntityApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = EntityApiService();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Entities", style: TextStyle(color: Colors.white)),
          ),
          body: EntityListView(
            widget.application,
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      EntityForm(widget.application)),
            ),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

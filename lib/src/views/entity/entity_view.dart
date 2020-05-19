import 'package:flutter/material.dart';
import 'package:pixri/src/model/entity_info.dart';
import 'package:pixri/src/model/entity.dart';
import 'package:pixri/src/api/entity_api_service.dart';
import 'package:pixri/src/views/fields/field_page.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class EntityView extends StatefulWidget {
  Entity entity;

  EntityView({@required this.entity});

  @override
  EntityViewState createState() => EntityViewState();
}

class EntityViewState extends State<EntityView> {
  EntityApiService apiService;
  EntityInfo _entityInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.entity != null) {}
    apiService = EntityApiService();
    apiService
        .getEntityInfo(widget.entity.id)
        .then((EntityInfo value) => setState(() {
      _entityInfo = value;
            }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.entity != null ? widget.entity.name : "",
            style: TextStyle(color: Colors.white)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("Description",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  widget.entity.description != null &&
                          widget.entity.description.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.entity.description,
                              textAlign: TextAlign.justify),
                        )
                      : Container(),
                  _entityInfo != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 100,
                              child: new InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FieldPage(
                                          entity: widget.entity)),
                                ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.redAccent,
                                elevation: 10,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.add_to_home_screen,
                                          size: 70),
                                      title: Text('Fields',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      subtitle: Text(
                                          _entityInfo.fieldCount.toString(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pixri/src/api/entity_api_service.dart';
import 'package:pixri/src/model/entity.dart';
import 'package:pixri/src/views/entity/entity_form.dart';
import 'package:pixri/src/views/entity/entity_view.dart';
import 'package:pixri/src/model/application.dart';

class EntityListView extends StatefulWidget {
  @override
 EntityListViewState createState() => EntityListViewState();
  Application application;
 EntityListView({this.application});

}


class EntityListViewState extends State<EntityListView> {
  EntityApiService apiService;



  @override
  void initState() {
    super.initState();
    apiService = EntityApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: () => apiService.getListOfEntityByApplication(widget.application.id),
            child: FutureBuilder(
              future: apiService.getListOfEntityByApplication(widget.application.id),
              builder: (BuildContext context, AsyncSnapshot<List<Entity>> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());

                  /// put an alert and
                  /// show text as 'something went wrong'
//                return Center(child: Text("Something wrong with message: ${snapshot.error.toString()}"));
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error, color: Colors.red),
                            Text("Something went wrong"),
                            SizedBox(height: 5),
                            Text("Pull down to refresh", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Entity> appList = snapshot.data;
                  return _buildListView(appList);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Entity> appList) {
    return appList != null
        ? ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Entity _entity = appList[index];
        return Container(
          padding: const EdgeInsets.only(top: 8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0, offset: Offset(3.0, 3.0))],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(_entity.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    _entity.description != null && _entity.description.isNotEmpty
                        ? Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(_entity.description, textAlign: TextAlign.justify),
                    )
                        : Container(),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.view_comfy, color: Colors.green, size: 16),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EntityView(entity: _entity)),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red, size: 16),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Are you sure want to delete this"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                apiService.deleteEntity(_entity.id).then((isSuccess) {
                                                  if (isSuccess) {
                                                    setState(() {});
                                                    Scaffold.of(this.context).showSnackBar(
                                                        SnackBar(content: Text("Delete data success")));
                                                  } else {
                                                    Scaffold.of(this.context).showSnackBar(
                                                        SnackBar(content: Text("Delete data failed")));
                                                  }
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue, size: 16),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EntityForm.fromEntity(entity: _entity)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: appList.length,
    )
        : Center(child: Text("No Entities Found."));
  }
}

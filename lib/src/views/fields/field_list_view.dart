import 'package:flutter/material.dart';
import 'package:pixri/src/api/field_api_service.dart';
import 'package:pixri/src/model/field.dart';
import 'package:pixri/src/views/fields/field_form.dart';
import 'package:pixri/src/model/entity.dart';

class FieldListView extends StatefulWidget {
  @override
  FieldListViewState createState() => FieldListViewState();
  Entity entity;
  FieldListView({this.entity});

}


class FieldListViewState extends State<FieldListView> {
  FieldApiService apiService;



  @override
  void initState() {
    super.initState();
    apiService = FieldApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: () => apiService.getListOfFieldByEntity(widget.entity.id),
            child: FutureBuilder(
              future: apiService.getListOfFieldByEntity(widget.entity.id),
              builder: (BuildContext context, AsyncSnapshot<List<Field>> snapshot) {
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
                  List<Field> appList = snapshot.data;
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

  Widget _buildListView(List<Field> appList) {
    return appList != null
        ? ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Field _field = appList[index];
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
                      child: Text(_field.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(_field.uiName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ), Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(_field.type, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

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
                                                apiService.deleteField(_field.id).then((isSuccess) {
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
                                  MaterialPageRoute(builder: (context) => FieldForm.fromField(field: _field)),
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

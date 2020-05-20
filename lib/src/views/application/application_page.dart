import 'package:flutter/material.dart';
import 'package:pixri/src/views/application/application_form.dart';
import 'package:pixri/src/api/application_api_service.dart';
import 'package:pixri/src/views/application/application_list_view.dart';

class ApplicationPage extends StatefulWidget {
  @override
  ApplicationPageStage createState() => ApplicationPageStage();
}

class ApplicationPageStage extends State<ApplicationPage> {
  ApplicationApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApplicationApiService();
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
            title: Text("Applications", style: TextStyle(color: Colors.white)),
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
          body: ApplicationListView(),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ApplicationForm()),
            ),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

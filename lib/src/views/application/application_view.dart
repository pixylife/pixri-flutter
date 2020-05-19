import 'package:flutter/material.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/model/application_info.dart';
import 'package:pixri/src/api/application_api_service.dart';
import 'package:pixri/src/views/theme/theme_list_view.dart';
import 'package:pixri/src/views/entity/entity_page.dart';
import 'package:pixri/src/util/HexColor.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ApplicationView extends StatefulWidget {
  Application application;

  ApplicationView({this.application});

  @override
  ApplicationViewState createState() => ApplicationViewState();
}

class ApplicationViewState extends State<ApplicationView> {
  ApplicationApiService apiService;
  ApplicationInfo _appInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.application != null) {}
    apiService = ApplicationApiService();
    apiService
        .getApplicationInfo(widget.application.id)
        .then((ApplicationInfo value) => setState(() {
              _appInfo = value;
            }));
       super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.application != null ? widget.application.name : "",
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
               Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      child: Text(
                        "Generate Flutter Application",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("Description",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  widget.application.description != null &&
                          widget.application.description.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.application.description,
                              textAlign: TextAlign.justify),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("Purpose",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  widget.application.purpose != null &&
                          widget.application.purpose.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.application.purpose,
                              textAlign: TextAlign.justify),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("Base URL",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  widget.application.baseURL != null &&
                          widget.application.baseURL.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(widget.application.baseURL,
                              textAlign: TextAlign.justify),
                        )
                      : Container(),

                       Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text("Selected Theme",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  widget.application.theme != null
                                        ? 
                   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Primary Color : " +  widget.application.theme.primaryColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor( widget.application.theme.primaryColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Secondary Color : " + widget.application.theme.secondaryColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(widget.application.theme.secondaryColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Body Color : " + widget.application.theme.bodyColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(widget.application.theme.bodyColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text(
                                "Text Color AppBar : " + widget.application.theme.textColorAppBar,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(widget.application.theme.textColorAppBar),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Text Color Body : " + widget.application.theme.textColorBody,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(widget.application.theme.textColorBody),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ],
                )
                : Container(),
                  _appInfo != null
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
                                      builder: (context) => EntityPage(
                                          application: widget.application)),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.pink,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.add_to_home_screen,
                                            size: 70),
                                        title: Text('Entities',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                            _appInfo.entityCount.toString(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                           
                            Container(
                              width: 200,
                              height: 100,
                              child: new InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThemeListView(
                                          application: widget.application)),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.greenAccent,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading:
                                            Icon(Icons.color_lens, size: 70),
                                        title: Text('Themes',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                            _appInfo.themeCount.toString(),
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

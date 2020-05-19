import 'package:flutter/material.dart';
import 'package:pixri/src/api/theme_api_service.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/model/theme.dart' as AppTheme;
import 'package:pixri/src/util/HexColor.dart';

class ThemeListView extends StatefulWidget {
  Application application;

  @override
  ThemeListViewState createState() => ThemeListViewState();

  ThemeListView({this.application});
}

class ThemeListViewState extends State<ThemeListView> {
  ThemeApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ThemeApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themes", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            onRefresh: () => apiService.getThemeByAppID(widget.application.id),
            child: FutureBuilder(
              future: apiService.getThemeByAppID(widget.application.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AppTheme.Theme>> snapshot) {
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
                            Text("Pull down to refresh",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<AppTheme.Theme> themeList = snapshot.data;
                  return _buildThemeListView(themeList);
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

  Widget _buildThemeListView(List<AppTheme.Theme> themeList) {
    return themeList != null
        ? GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              AppTheme.Theme _theme = themeList[index];
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(3.0, 3.0))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Primary Color : " + _theme.primaryColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(_theme.primaryColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Secondary Color : " + _theme.secondaryColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(_theme.secondaryColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Body Color : " + _theme.bodyColor,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(_theme.bodyColor),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text(
                                "Text Color AppBar : " + _theme.textColorAppBar,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(_theme.textColorAppBar),
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Text("Text Color Body : " + _theme.textColorBody,
                                textAlign: TextAlign.justify),
                            Icon(
                              Icons.stop,
                              color: HexColor(_theme.textColorBody),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: themeList.length,
          )
        : Center(child: Text("No Themes Found."));
  }
}

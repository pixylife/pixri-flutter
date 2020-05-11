import 'package:pixri/src/model/application.dart';
import 'dart:convert';


class Theme {
  int id;
  String primaryColor;
  String secondaryColor;
  String primaryDarkColor;
  String bodyColor;
  String textColorBody;
  String textColorAppBar;
  int applicationId;
  Application application;

  Theme({this.id, this.primaryColor, this.secondaryColor, this.primaryDarkColor, this.bodyColor, this.textColorBody, this.textColorAppBar, this.applicationId, this.application});

  Theme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    primaryColor = json['primary_color'];
    secondaryColor = json['secondary_color'];
    primaryDarkColor = json['primary_dark_color'];
    bodyColor = json['body_color'];
    textColorBody = json['text_color_body'];
    textColorAppBar = json['text_color_appBar'];
    applicationId = json['application_id'];
    application = json['application'] != null ? new Application.fromJson(json['application']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['primary_color'] = this.primaryColor;
    data['secondary_color'] = this.secondaryColor;
    data['primary_dark_color'] = this.primaryDarkColor;
    data['body_color'] = this.bodyColor;
    data['text_color_body'] = this.textColorBody;
    data['text_color_appBar'] = this.textColorAppBar;
    data['application_id'] = this.applicationId;
    if (this.application != null) {
      data['application'] = this.application.toJson();
    }
    return data;
  }
}


List<Theme> themeListFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Theme>.from(data.map((item) => Theme.fromJson(item)));
}

Theme themeFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return data.map((item) => Theme.fromJson(item));
}

String themeToJson(Theme data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
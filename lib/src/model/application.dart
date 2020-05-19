import 'dart:convert';

import 'package:pixri/src/model/theme.dart';

class Application {
  int id;
  String name;
  String type;
  String description;
  AgeGroup ageGroup;
  String purpose;
  String baseURL;
  String company;
  int selectedTheme;
  Theme theme;

  Application(
      {this.id,
      this.name,
      this.type,
      this.description,
      this.ageGroup,
      this.purpose,
      this.baseURL,
      this.company,
      this.selectedTheme,
      this.theme});

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    ageGroup = json['age-group'] != null
        ? new AgeGroup.fromJson(json['age-group'])
        : null;
    purpose = json['purpose'];
    baseURL = json['baseURL'];
    company = json['company'];
    selectedTheme = json['selected_theme'];
    theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;

    print("XXX"+theme.primaryColor);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    if (this.ageGroup != null) {
      data['age-group'] = this.ageGroup.toJson();
    }
    data['purpose'] = this.purpose;
    data['baseURL'] = this.baseURL;
    data['company'] = this.company;
    data['selected_theme'] = this.selectedTheme;
    if (this.theme != null) {
      data['theme'] = this.theme.toJson();
    }
    return data;
  }
}

class AgeGroup {
  int min;
  int max;

  AgeGroup({this.min, this.max});

  AgeGroup.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

List<Application> applicationListFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Application>.from(data.map((item) => Application.fromJson(item)));
}

Application applicationFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return data.map((item) => Application.fromJson(item));
}

String applicationToJson(Application data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

import 'dart:convert';

class ApplicationInfo {
  int id;
  int themeCount;
  int entityCount;
  int pageCount;

  ApplicationInfo({this.id, this.themeCount, this.entityCount, this.pageCount});

  ApplicationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    themeCount = json['theme_count'];
    entityCount = json['entity_count'];
    pageCount = json['page_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['theme_count'] = this.themeCount;
    data['entity_count'] = this.entityCount;
    data['page_count'] = this.pageCount;
    return data;
  }
}

ApplicationInfo applicationInfoFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return ApplicationInfo(themeCount: data['theme_count'],pageCount: data['entity_count'],entityCount: data['entity_count'],id: data['id']);
}


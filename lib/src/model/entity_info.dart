import 'dart:convert';

class EntityInfo {
  int id;
  int fieldCount;

  EntityInfo({this.id, this.fieldCount});

  EntityInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldCount = json['field_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field_count'] = this.fieldCount;
    return data;
  }


}


EntityInfo entityInfoFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return EntityInfo(fieldCount: data['field_count'],id: data['id']);
}

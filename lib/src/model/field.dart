import 'dart:convert';

class Field {
  int id;
  String name;
  String type;
  String uiName;
  int entityId;

  Field({this.id, this.name, this.type, this.uiName, this.entityId});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uiName = json['ui_name'];
    entityId = json['entity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['ui_name'] = this.uiName;
    data['entity_id'] = this.entityId;
    return data;
  }
}
List<Field> fieldListFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Field>.from(data.map((item) => Field.fromJson(item)));
}

Field fieldFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return data.map((item) => Field.fromJson(item));
}

String fieldToJson(Field data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
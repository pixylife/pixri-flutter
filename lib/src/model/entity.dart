import 'dart:convert';

class Entity {
  int id;
  String name;
  String description;
  int applicationId;

  Entity({this.id, this.name, this.description, this.applicationId});

  Entity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    applicationId = json['application_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['application_id'] = this.applicationId;
    return data;
  }
}


List<Entity> entityListFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Entity>.from(data.map((item) => Entity.fromJson(item)));
}

Entity entityFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return data.map((item) => Entity.fromJson(item));
}

String entityToJson(Entity data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
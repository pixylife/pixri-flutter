import 'dart:convert';
import 'package:pixri/src/model/entity.dart';
import 'package:pixri/src/model/entity_info.dart';
import 'package:pixri/src/api/base_api.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer';

class EntityApiService extends BaseApi {
  Client client = Client();

  Future<bool> createEntity(Entity data) async {
    final response = await client.post(
      "$baseUrl/entitys",
      headers: {"content-type": "application/json"},
      body: entityToJson(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteEntity(int id) async {
    final response = await client.delete(
      "$baseUrl/entitys/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEntity(Entity data) async {
    final response = await client.put(
      "$baseUrl/entitys",
      headers: {"content-type": "application/json"},
      body: entityToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Entity> getEntity(int id) async {
    final response = await client.get("$baseUrl/entitys/$id");

    if (response.statusCode == 200) {
      return entityFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Entity>> getListOfEntity() async {
    final response = await client.get("$baseUrl/entitys");
    if (response.statusCode == 200) {
      return entityListFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Entity>> getListOfEntityByApplication(int id) async {
    final response = await client.get("$baseUrl/entitys/application/$id");
    if (response.statusCode == 200) {
      return entityListFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<EntityInfo> getEntityInfo(int id) async {
    final response = await client.get("$baseUrl/entitys/info/$id");
    if (response.statusCode == 200) {
      return entityInfoFromJson(response.body);
    } else {
      return null;
    }
  }
}

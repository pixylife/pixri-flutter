import 'package:pixri/src/model/field.dart';
import 'package:pixri/src/api/base_api.dart';
import 'package:http/http.dart' show Client;

class FieldApiService extends BaseApi {
  Client client = Client();

  Future<bool> createField(Field data) async {
    final response = await client.post(
      "$baseUrl/fields",
      headers: {"content-type": "application/json"},
      body: fieldToJson(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteField(int id) async {
    final response = await client.delete(
      "$baseUrl/fields/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateField(Field data) async {
    final response = await client.put(
      "$baseUrl/fields",
      headers: {"content-type": "application/json"},
      body: fieldToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Field> getField(int id) async {
    final response = await client.get("$baseUrl/fields/$id");

    if (response.statusCode == 200) {
      return fieldFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Field>> getListOfField() async {
    final response = await client.get("$baseUrl/fields");
    if (response.statusCode == 200) {
      return fieldListFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Field>> getListOfFieldByEntity(int id) async {
    final response = await client.get("$baseUrl/fields/entity/$id");
    if (response.statusCode == 200) {
      return fieldListFromJson(response.body);
    } else {
      return null;
    }
  }
}

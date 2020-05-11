import 'dart:convert';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/model/application_info.dart';
import 'package:pixri/src/api/base_api.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer';

class ApplicationApiService extends BaseApi{
  Client client = Client();

  Future<bool> createApplication(Application data) async{

    final response = await client.post(
      "$baseUrl/applications",
      headers: {"content-type": "application/json"},
      body: applicationToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteApplication(int id) async {
    final response = await client.delete(
      "$baseUrl/applications/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateApplication(Application data) async {
    final response = await client.put(
      "$baseUrl/applications/${data.id}",
      headers: {"content-type": "application/json"},
      body: applicationToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Application> getApplication(int id) async {
    final response = await client.get("$baseUrl/applications/$id");


    if (response.statusCode == 200) {
      return applicationFromJson(response.body);
    } else {
      return null;
    }
  }


  Future<List<Application>> getListOfApplication() async {
    final response = await client.get("$baseUrl/applications");
    if (response.statusCode == 200) {
      return applicationListFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<ApplicationInfo> getApplicationInfo(int id) async {
    final response = await client.get("$baseUrl/applications/info/$id");
    if (response.statusCode == 200) {
      return applicationInfoFromJson(response.body);
    } else {
      return null;
    }
  }

}

import 'package:pixri/src/api/base_api.dart';
import 'package:pixri/src/model/theme.dart' as AppTheme;
import 'package:http/http.dart' show Client;
import 'package:pixri/src/model/application.dart';

class ThemeApiService extends BaseApi{
  Client client = Client();


  Future<List<AppTheme.Theme>> getThemeByAppID(int id) async {
    final response = await client.get("$baseUrl/themes/app/$id");
    if (response.statusCode == 200) {
      return AppTheme.themeListFromJson(response.body);
    } else {
      return null;
    }
  }


 Future<bool> updateApplicationTheme(Application data) async {
    final response = await client.put(
      "$baseUrl/applications/theme",
      headers: {"content-type": "application/json"},
      body: applicationToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


}

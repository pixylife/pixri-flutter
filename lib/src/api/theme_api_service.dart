import 'package:pixri/src/api/base_api.dart';
import 'package:pixri/src/model/theme.dart' as AppTheme;
import 'package:http/http.dart' show Client;

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


}

import 'package:shared_preferences/shared_preferences.dart';

class ServicesConfig {
  static String base_url = "https://elprincessa.com/api";

  static Future<Map<String, String>> getHeader() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var header = {
      "language": "ar",
    };
    return header;
  }

  static Future<Map<String, String>?> getHeaderWithToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    if (token != null) {
      var header = {"language": "ar", "Authorization": "Bearer " + token};
      return header;
    } else {
      return null;
    }
  }
}

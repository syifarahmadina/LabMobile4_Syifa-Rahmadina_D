import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    try {
      // Panggil API dan langsung terima hasil JSON (tanpa perlu decode lagi)
      var response = await Api().post(apiUrl, body);

      // Akses data dari response langsung karena sudah berupa Map/JSON
      if (response['code'] == 200 && response['status'] == true) {
        return Login.fromJson(response);
      } else {
        throw Exception('Login gagal: ${response['data']}');
      }
    } catch (error) {
      print("Login Error: $error");
      rethrow;
    }
  }
}
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

void isLogin({required bool isLogin}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogin', isLogin);
}

void storeUserId({String? userId}) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('userId', userId ?? "");
}

Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

void storeClientId({String? clientId}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('clientId', clientId ?? "");
}

Future<String?> getClientId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('clientId');
}
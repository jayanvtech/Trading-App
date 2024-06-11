import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradingapp/Authentication/login_data/login_data.dart';

class LoginRepository {
  Future<User> login(String username, String password) async {
    final url = Uri.parse('https://your-api-endpoint.com/login'); // Replace with your actual URL
    final response = await http.post(url, body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['type'] == 'success') {
        return User.fromJson(data['result']);
      } else {
        throw Exception(data['description']);
      }
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}
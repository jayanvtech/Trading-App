import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tradingapp/Utils/Bottom_nav_bar_screen.dart';

class ValidPasswordScreen extends StatefulWidget {
  String userID;
  ValidPasswordScreen({super.key, required this.userID});

  @override
  State<ValidPasswordScreen> createState() => _ValidPasswordScreenState();
}

class _ValidPasswordScreenState extends State<ValidPasswordScreen> {
  late TextEditingController userIDController =
      TextEditingController(text: widget.userID);
  final TextEditingController pinController = TextEditingController();

  Future<Map<String, dynamic>> validatePin(String userID, String pin) async {
    try {
      var url =
          Uri.parse('http://14.97.72.10:3000/enterprise/auth/validatepin');
      var response = await http.post(
        url,
        body: jsonEncode({
          'userID': userID.toString(),
          'pin': pin.toString(),
          'source': 'EnterpriseWeb',
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['type'] == 'success') {
          print(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (jsonResponse['result'] != null &&
              jsonResponse['result']['token'] != null) {
            await prefs.setString('token', jsonResponse['result']['token']);
            print('Stored token: ${prefs.getString('token')}');
            Get.offAll(() => MainScreen());
          } else {
            print('Token not found in the response');
          }
          return {
            'status': true,
            'message': 'Pin validation successful',
            'data': jsonResponse['result']
          };
        } else {
          return {'status': false, 'message': jsonResponse['description']};
        }
      } else {
        if (jsonResponse['type'] == 'error') {
          return {'status': false, 'message': jsonResponse['description']};
        } else if (jsonResponse['result'] != null &&
            jsonResponse['result']['errors'] != null) {
          List errors = jsonResponse['result']['errors'];
          String errorMessage =
              errors.map((e) => e['messages'].join(' ')).join('\n');
          return {'status': false, 'message': errorMessage};
        } else {
          print(response.body);
          throw Exception('Failed to load API response');
        }
      }
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valid Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: userIDController,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                ),
              ),
              TextField(
                controller: pinController,
                decoration: const InputDecoration(
                  labelText: 'Pin',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    var result = await validatePin(
                        userIDController.text, pinController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result['message'])),
                    );
                  },
                  child: const Text('Validate Pin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

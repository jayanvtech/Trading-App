import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tradingapp/Authentication/Login_bloc/login_bloc.dart';
import 'package:tradingapp/Authentication/Login_bloc/login_event.dart';
import 'package:tradingapp/Authentication/Login_bloc/login_state.dart';
import 'package:tradingapp/Authentication/const.dart/custom_textformfield.dart';
import 'package:tradingapp/Authentication/forget_password_screen.dart';
import 'package:tradingapp/Authentication/tpin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'A0031');
  final _passwordController = TextEditingController(text: 'Xts@987');
  final _validpinController = TextEditingController();
  String erorrname = 'HUP';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            print(state);
            if (state is LoginSuccess) {
              Get.snackbar('Success', state.message.toString());
              Get.to(
                  () => ValidPasswordScreen(userID: _usernameController.text));
            } else if (state is LoginFailure) {
              Get.snackbar('Error', state.error.toString());
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _usernameController,
                          labelText: 'Username',
                          icon: Icons.person,
                          errorMessage: 'username',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          icon: Icons.person,
                          errorMessage: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Forget Password? ",
                                style: TextStyle(color: Colors.blue)),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => ForgetPasswordScreen(
                                      username: _usernameController.text));
                                },
                                child: const Text("Click Here"))
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)))),
                                onPressed: () {
                                  _usernameController.clear();
                                  _passwordController.clear();
                                },
                                child: const Text('Clear'),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var username = _usernameController.text;
                                    var password = _passwordController.text;
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginUserEvent(
                                          userID: _usernameController.text,
                                          password: _passwordController.text,
                                        ));
                                    // var response =
                                    //     await loginUser("A0031", "Xts@987");
                                    // if (response['status']) {
                                    //   Get.to(() => const ValidPasswordScreen());
                                    // } else {
                                    //   Get.snackbar('Error', response['message']);
                                    // }
                                    // print(response);
                                  }
                                },
                                child: const Text(
                                  "Login",
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> loginUser(String userID, String password) async {
    try {
      var url =
          Uri.parse('http://14.97.72.10:3000/enterprise/auth/validateuser');
      var response = await http.post(
        url,
        body: jsonEncode({
          "userID": userID.toString(),
          "password": password.toString(),
          "source": "EnterpriseWEB"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['type'] == 'success') {
          print(jsonResponse['description']);

          Get.to(() => ValidPasswordScreen(userID: userID));
          return {'status': true, 'message': 'Login successful'};
        } else {
          return {'status': false, 'message': jsonResponse['description']};
        }
      } else {
        print(response.body);
        throw Exception('Failed to load API response');
      }
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': 'An error occurred'};
    }
  }
}

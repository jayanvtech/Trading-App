import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradingapp/Authentication/Login_bloc/login_event.dart';
import 'package:tradingapp/Authentication/Login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());
      var result = await loginUser(event.userID, event.password);
      if (result['status']) {
        emit(LoginSuccess(message: result['message'].toString()));
        
      } else if (!result['status']) {
        emit(LoginFailure(error: result['message'].toString()));
      }
    });

    on<LoginSuccessEvent>((event, emit) {
      emit(LoginSuccess(message: event.message));
    });

    on<LoginErrorEvent>((event, emit) {
      emit(LoginFailure(error: event.error));
    });
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
          "source": "EnterpriseMobile"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        return {
          'status': false,
          'message': jsonDecode(response.body)['description']
        };
      }

      return {
        'status': true,
        'message': jsonDecode(response.body)['description']
      };
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.toString()};
    }
  }
}

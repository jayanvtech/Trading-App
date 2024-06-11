abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String userID;
  final String password;

  LoginUserEvent({required this.userID, required this.password});
}

class LoginSuccessEvent extends LoginEvent {
  final String message;

  LoginSuccessEvent({required this.message});
}

class LoginErrorEvent extends LoginEvent {
  final String error;

  LoginErrorEvent({required this.error});
}
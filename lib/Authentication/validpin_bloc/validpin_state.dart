

sealed class ValidpinState {}

final class ValidpinInitial extends ValidpinState {}

final class ValidPinLoading extends ValidpinState {}

final class ValidPinSuccess extends ValidpinState {
  final String message;
  ValidPinSuccess(this.message);
}

final class ValidPinError extends ValidpinState {
  final String error;
  ValidPinError(this.error);
}

final class ValidPinFailure extends ValidpinState {
  final String error;
  ValidPinFailure(this.error);
}


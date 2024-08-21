enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({required this.status, this.errorMessage});

  factory LoginState.initial() => LoginState(status: LoginStatus.initial);
  factory LoginState.loading() => LoginState(status: LoginStatus.loading);
  factory LoginState.success() => LoginState(status: LoginStatus.success);
  factory LoginState.error(String errorMessage) =>
      LoginState(status: LoginStatus.error, errorMessage: errorMessage);
}
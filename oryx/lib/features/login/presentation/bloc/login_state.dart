part of 'login_bloc.dart';

enum LoginStatus {
  unknown,
  loginInitial,
}

final class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final EmailFormzModel email;
  final CommonFormzModel password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool rememberMe;
  final LoginEntity? loginEntity;
  final String? errorMessage;

  const LoginState({
    this.loginStatus = LoginStatus.unknown,
    this.email = const EmailFormzModel.pure(),
    this.password = const CommonFormzModel.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.rememberMe = false,
    this.loginEntity,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        loginStatus,
        email,
        password,
        status,
        isValid,
        rememberMe,
        loginEntity,
        errorMessage,
      ];

  LoginState copyWith({
    LoginStatus? loginStatus,
    EmailFormzModel? email,
    CommonFormzModel? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? remindMe,
    LoginEntity? loginEntity,
    String? errorMessage,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      rememberMe: remindMe ?? rememberMe,
      loginEntity: loginEntity ?? this.loginEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

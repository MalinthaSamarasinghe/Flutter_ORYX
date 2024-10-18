part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  final LoginStatus loginStatus;

  const LoginEvent({
    required this.loginStatus,
  });

  @override
  List<Object> get props => [loginStatus];
}

/// getUserEmail
class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email) : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [email];
}

/// getUserPassword
class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password) : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [password];
}

/// getRememberMe
class RememberMeTapped extends LoginEvent {
  final bool isRemember;

  const RememberMeTapped({required this.isRemember}) : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [isRemember];
}

/// getPasswordUserLogin
class PasswordLoginRequested extends LoginEvent {
  const PasswordLoginRequested() : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [];
}

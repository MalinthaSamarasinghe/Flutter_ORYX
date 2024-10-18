part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoggedIn extends AuthEvent {
  final LoginEntity? loginEntity;
  final AuthStatus authenticationStatus;

  const LoggedIn({
    required this.loginEntity,
    required this.authenticationStatus,
  });

  @override
  List<Object?> get props => [loginEntity, authenticationStatus];
}

class LoggedOut extends AuthEvent {
  const LoggedOut();

  @override
  List<Object?> get props => [];
}

class SessionExpired extends AuthEvent {
  const SessionExpired();

  @override
  List<Object?> get props => [];
}

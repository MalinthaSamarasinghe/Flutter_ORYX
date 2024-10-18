part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  sessionExpired,
  logOutInProgress,
}

class AuthState extends Equatable {
  final AuthStatus authenticationStatus;
  final LoginEntity? loginEntity;

  const AuthState({
    this.authenticationStatus = AuthStatus.unauthenticated,
    this.loginEntity,
  });

  @override
  List<Object?> get props => [authenticationStatus, loginEntity];

  AuthState copyWith({
    AuthStatus? authenticationStatus,
    LoginEntity? loginEntity,
  }) {
    return AuthState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      loginEntity: loginEntity ?? this.loginEntity,
    );
  }
}

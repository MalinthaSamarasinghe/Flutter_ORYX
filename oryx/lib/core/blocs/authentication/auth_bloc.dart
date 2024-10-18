import 'dart:async';
import '../event_transformer.dart';
import 'package:equatable/equatable.dart';
import '../../entities/user/login_entity.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoggedIn>(_loggedIn, transformer: Transformer.throttleDroppable());
    on<LoggedOut>(_loggedOut, transformer: Transformer.throttleDroppable());
    on<SessionExpired>(_sessionExpired, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _loggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authenticationStatus: event.authenticationStatus,
      loginEntity: event.loginEntity,
    ));
  }

  Future<FutureOr<void>> _loggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      authenticationStatus: AuthStatus.logOutInProgress,
    ));

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(
      authenticationStatus: AuthStatus.unauthenticated,
    ));
  }

  FutureOr<void> _sessionExpired(SessionExpired event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authenticationStatus: AuthStatus.sessionExpired,
    ));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    AuthStatus authStatus = AuthStatus.unauthenticated;

    String authStatusString = json["authenticationStatus"];
    if (authStatusString == "AuthStatus.authenticated") {
      authStatus = AuthStatus.authenticated;
    } else if (authStatusString == "AuthStatus.unauthenticated") {
      authStatus = AuthStatus.unauthenticated;
    } else {
      authStatus = AuthStatus.unauthenticated;
    }

    return AuthState(
      loginEntity: json["loginEntity"] == null ? null : LoginEntity.fromJson(json["loginEntity"]),
      authenticationStatus: authStatus,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      "loginEntity": state.loginEntity?.toJson(),
      "authenticationStatus": state.authenticationStatus.toString(),
    };
  }
}

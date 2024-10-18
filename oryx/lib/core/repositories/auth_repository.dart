import 'dart:async';
import '../blocs/authentication/auth_bloc.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get stream;

  void sessionExpired();
}

class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<AuthStatus>();

  @override
  Stream<AuthStatus> get stream => _controller.stream;

  @override
  void sessionExpired() {
    _controller.add(AuthStatus.unauthenticated);
  }
}

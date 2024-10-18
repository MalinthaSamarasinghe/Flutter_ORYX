import 'dart:developer';
import 'package:dio/dio.dart';
import '../../blocs/authentication/auth_bloc.dart';

/// Request methods PUT, POST, PATCH, DELETE needs access token,
/// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  AuthBloc authBloc;

  AuthorizationInterceptor({
    required this.authBloc,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer ${authBloc.state.loginEntity}";
    log("onRequest called ${options.data}\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("onResponse called $response\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      authBloc.add(const SessionExpired());
    }
    log("onError called $err\n");
    super.onError(err, handler);
  }
}

import 'package:dio/dio.dart';
import '../network/server_error_data.dart';

/// Exception for the HTTP requests from Dio
class ServerException implements Exception {
  late String errorMessage;
  late bool unexpectedError;
  ServerErrorData? data;

  ServerException({required this.errorMessage, required this.unexpectedError});

  /// Constructor for Dio package
  ServerException.fromDioError(DioException dioError) {
    data = ServerErrorData.fromDioError(dioError);
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request to the server was canceled.";
        unexpectedError = false;
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receiving timeout occurred. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Request send timed out. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioError.response);
        break;
      case DioExceptionType.unknown:
        if ((dioError.message ?? "").contains('SocketException')) {
          errorMessage = "Request failed. Make sure your connection has internet access.";
          unexpectedError = false;
          break;
        }
        errorMessage = "Unexpected error occurred.";
        unexpectedError = true;
        break;
      default:
        errorMessage = "Something went wrong!";
        unexpectedError = true;
        break;
    }
  }

  String _handleStatusCode(Response? response) {
    int? statusCode = response?.statusCode;
    switch (statusCode) {
      case 400:
        unexpectedError = true;
        return "Bad request!";
      case 401:
        unexpectedError = false;
        return "Authentication failed. Please log in again!";
      case 403:
        unexpectedError = false;
        return "The authenticated user is not allowed to access the specified API endpoint.";
      case 404:
        unexpectedError = true;
        return "The requested resource does not exist!";
      case 405:
        unexpectedError = true;
        return "Method not allowed. Please check the Allow header for the allowed HTTP methods.";
      case 410:
        unexpectedError = true;
        return "This email is not found!";
      case 415:
        unexpectedError = true;
        return "Unsupported media type. The requested content type or version number is invalid.";
      case 420:
        unexpectedError = true;
        return "Failed to verify email!";
      case 422:
        unexpectedError = false;
        return "Data validation failed!";
      case 429:
        unexpectedError = true;
        return "Too many requests!";
      case 500:
        unexpectedError = true;
        return "Internal server error. Please contact admin!";
      default:
        unexpectedError = true;
        return "Oops something went wrong! Error ${statusCode.toString()}";
    }
  }

  @override
  String toString() {
    return 'ServerException{errorMessage: $errorMessage, unexpectedError: $unexpectedError, data: $data}';
  }
}

/// Throws when there's no shared pref data to fetch
class CacheException implements Exception {}

/// Use to throw exception when the user not grant device permissions
class NoPermission implements Exception {}

/// Use to throw platform related exceptions
class DeviceException implements Exception {
  final String message;

  const DeviceException({
    required this.message,
  });
}

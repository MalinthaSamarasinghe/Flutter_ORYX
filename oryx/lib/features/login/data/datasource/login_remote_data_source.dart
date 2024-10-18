import 'package:dio/dio.dart';
import '../model/login_model.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../../../core/network/dio_client.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> getLoginUser(LoginDetailsParam loginDetails);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient dioClient;

  LoginRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginModel> getLoginUser(LoginDetailsParam loginDetailsParam) async {
    try {
      Response response = await dioClient.public.post(
        ApiEndpoints.login,
        data: loginDetailsParam.toMap(),
      );
      return loginFromJson(response.data);
    } on DioException catch (err) {
      throw ServerException.fromDioError(err);
    } catch (e) {
      throw ServerException(errorMessage: "$e", unexpectedError: true);
    }
  }
}

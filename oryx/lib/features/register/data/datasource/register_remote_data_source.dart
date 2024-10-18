import 'package:dio/dio.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../login/data/model/login_model.dart';
import '../../domain/usecase/register_usecase.dart';

abstract class RegisterRemoteDataSource {
  Future<LoginModel> getRegisterUser(RegisterDetailsParam registerDetails);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final DioClient dioClient;

  RegisterRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginModel> getRegisterUser(RegisterDetailsParam registerDetailsParam) async {
    try {
      Response response = await dioClient.public.post(
        ApiEndpoints.register,
        data: registerDetailsParam.toMap(),
      );
      return loginFromJson(response.data);
    } on DioException catch (err) {
      throw ServerException.fromDioError(err);
    } catch (e) {
      throw ServerException(errorMessage: "$e", unexpectedError: true);
    }
  }
}

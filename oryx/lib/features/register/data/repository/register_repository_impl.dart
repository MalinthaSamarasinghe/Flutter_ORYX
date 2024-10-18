import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/usecase/register_usecase.dart';
import '../datasource/register_remote_data_source.dart';
import '../../domain/repository/register_repository.dart';
import '../../../../core/entities/user/login_entity.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource remoteDataSource;

  const RegisterRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> registerUser(RegisterDetailsParam registerDetailsParam) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final userDetails = await remoteDataSource.getRegisterUser(registerDetailsParam);
        return Right(userDetails.toEntity());
      } on ServerException catch (serverException) {
        return Left(ServerFailure(message: serverException.errorMessage));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}

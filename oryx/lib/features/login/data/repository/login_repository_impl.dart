import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/login_remote_data_source.dart';
import '../../domain/repository/login_repository.dart';
import '../../../../core/entities/user/login_entity.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;

  const LoginRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> loginUser(LoginDetailsParam loginDetails) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final userDetails = await remoteDataSource.getLoginUser(loginDetails);
        return Right(userDetails.toEntity());
      } on ServerException catch (serverException) {
        return Left(ServerFailure(message: serverException.errorMessage));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}

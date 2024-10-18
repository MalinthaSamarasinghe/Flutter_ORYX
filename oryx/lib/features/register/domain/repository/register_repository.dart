import 'package:dartz/dartz.dart';
import '../usecase/register_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/entities/user/login_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, LoginEntity>> registerUser(RegisterDetailsParam registerDetailsParam);
}

import 'package:dartz/dartz.dart';
import '../usecase/login_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/entities/user/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> loginUser(LoginDetailsParam loginDetailsParam);
}

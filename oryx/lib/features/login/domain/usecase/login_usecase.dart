import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repository/login_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/entities/user/login_entity.dart';

class LoginUseCase implements UseCase<LoginEntity, LoginDetailsParam> {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginDetailsParam loginDetailsParam) async {
    return await loginRepository.loginUser(loginDetailsParam);
  }
}

class LoginDetailsParam extends Equatable {
  final String email;
  final String password;

  const LoginDetailsParam({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}

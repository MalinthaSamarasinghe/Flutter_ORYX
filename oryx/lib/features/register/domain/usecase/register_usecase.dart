import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repository/register_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/entities/user/login_entity.dart';

class RegisterUseCase implements UseCase<LoginEntity, RegisterDetailsParam> {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(RegisterDetailsParam registerDetailsParam) async {
    return await registerRepository.registerUser(registerDetailsParam);
  }
}

class RegisterDetailsParam extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterDetailsParam({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [name, email, password, passwordConfirmation];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}

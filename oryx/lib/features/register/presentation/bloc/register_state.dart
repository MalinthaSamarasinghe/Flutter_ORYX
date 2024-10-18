part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  final NameFormzModel name;
  final EmailFormzModel email;
  final PasswordFormzModel password;
  final PasswordFormzModel confirmedPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final LoginEntity? loginEntity;
  final String? errorMessage;

  const RegisterState({
    this.name = const NameFormzModel.pure(),
    this.email = const EmailFormzModel.pure(),
    this.password = const PasswordFormzModel.pure(PasswordParameters(isPasswordField: true, password: "", confirmPassword: "")),
    this.confirmedPassword = const PasswordFormzModel.pure(PasswordParameters(isPasswordField: false, password: "", confirmPassword: "")),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.loginEntity,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmedPassword,
        status,
        isValid,
        loginEntity,
        errorMessage,
      ];

  RegisterState copyWith({
    NameFormzModel? name,
    EmailFormzModel? email,
    PasswordFormzModel? password,
    PasswordFormzModel? confirmedPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    LoginEntity? loginEntity,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      loginEntity: loginEntity ?? this.loginEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

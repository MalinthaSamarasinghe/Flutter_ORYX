part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

/// getName
class GetNameChanged extends RegisterEvent {
  final String name;

  const GetNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

/// getEmail
class GetEmailChanged extends RegisterEvent {
  final String email;

  const GetEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// getPassword
class GetPasswordChanged extends RegisterEvent {
  final String passWord;
  final String confirmPassWord;

  const GetPasswordChanged(this.passWord, this.confirmPassWord);

  @override
  List<Object> get props => [passWord, confirmPassWord];
}

/// getConfirmedPassword
class GetConfirmedPasswordChanged extends RegisterEvent {
  final String passWord;
  final String confirmPassWord;

  const GetConfirmedPasswordChanged(this.passWord, this.confirmPassWord);

  @override
  List<Object> get props => [passWord, confirmPassWord];
}

/// getAccountCreation
class GetAccountCreationRequested extends RegisterEvent {
  const GetAccountCreationRequested();

  @override
  List<Object> get props => [];
}

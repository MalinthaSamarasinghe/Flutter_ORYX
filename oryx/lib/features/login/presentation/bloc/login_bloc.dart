import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecase/login_usecase.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../../../core/entities/user/login_entity.dart';
import '../../../../core/models/form_inputs/email_formz_model.dart';
import '../../../../core/models/form_inputs/common_formz_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  /// TextEditingController
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  /// FocusNode
  final FocusNode userEmailNode = FocusNode();
  final FocusNode userPasswordNode = FocusNode();

  @override
  Future<void> close() {
    userEmailController.dispose();
    userPasswordController.dispose();
    userEmailNode.dispose();
    userPasswordNode.dispose();
    return super.close();
  }

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
    on<EmailChanged>(_onUserEmailChanged, transformer: Transformer.throttleDebounce());
    on<PasswordChanged>(_onUserPasswordChanged, transformer: Transformer.throttleDebounce());
    on<RememberMeTapped>(_rememberMeTapped, transformer: Transformer.throttleDroppable());
    on<PasswordLoginRequested>(_onPasswordLoginRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onUserEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = EmailFormzModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        loginStatus: LoginStatus.unknown,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  FutureOr<void> _onUserPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = CommonFormzModel.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        loginStatus: LoginStatus.unknown,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  FutureOr<void> _rememberMeTapped(RememberMeTapped event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        remindMe: event.isRemember,
        status: FormzSubmissionStatus.initial,
        loginStatus: LoginStatus.unknown,
      ),
    );
  }

  FutureOr<void> _onPasswordLoginRequested(PasswordLoginRequested event, Emitter<LoginState> emit) async {
    if (state.status == FormzSubmissionStatus.failure) {
      emit(state.copyWith(
        isValid: Formz.validate([state.email, state.password]),
      ));
    }

    if (state.status == FormzSubmissionStatus.initial || !state.isValid) {
      final email = EmailFormzModel.dirty(state.email.value);
      final password = CommonFormzModel.dirty(state.password.value);

      emit(state.copyWith(
        email: email,
        password: password,
        isValid: Formz.validate([email, password]),
      ));
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      LoginDetailsParam loginDetails = LoginDetailsParam(
        email: state.email.value,
        password: state.password.value,
      );
      Either<Failure, LoginEntity> result = await loginUseCase(loginDetails);
      result.fold(
        (failure) {
          String message = "";
          if (failure is ServerFailure) {
            message = failure.message;
          } else if (failure is NoConnectionFailure) {
            message = "Please check your internet connection and try again!";
          } else {
            message = "Data fetching failed. Please try again later!";
          }
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: message,
          ));
        },
        (loginEntity) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            loginEntity: loginEntity,
          ));
        },
      );
    }
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    bool rememberMe = json['rememberMe'] ?? false;
    String? email = json['email'];
    String? password = json['password'];

    return LoginState(
      rememberMe: rememberMe,
      email: email == null || email == "" || !rememberMe ? const EmailFormzModel.pure() : EmailFormzModel.dirty(email),
      password: password == null || password == "" || !rememberMe ? const CommonFormzModel.pure() : CommonFormzModel.dirty(password),
      loginStatus: LoginStatus.unknown,
      status: FormzSubmissionStatus.initial,
      errorMessage: "",
    );
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return {
      "rememberMe": state.rememberMe,
      "email" : state.email.value,
      "password" : state.password.value,
    };
  }
}

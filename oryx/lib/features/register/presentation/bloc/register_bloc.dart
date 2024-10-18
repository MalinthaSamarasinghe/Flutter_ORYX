import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/register_usecase.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../../../core/entities/user/login_entity.dart';
import '../../../../core/models/form_inputs/name_form_model.dart';
import '../../../../core/models/form_inputs/email_formz_model.dart';
import '../../../../core/models/form_inputs/password_formz_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  /// TextEditingController
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();

  /// FocusNode
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmedPasswordNode = FocusNode();

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    nameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmedPasswordNode.dispose();
    return super.close();
  }

  RegisterBloc({required this.registerUseCase}) : super(const RegisterState()) {
    on<GetNameChanged>(_onGetNameChanged, transformer: Transformer.throttleDebounce());
    on<GetEmailChanged>(_onGetEmailChanged, transformer: Transformer.throttleDebounce());
    on<GetPasswordChanged>(_onGetPasswordChanged, transformer: Transformer.throttleDebounce());
    on<GetConfirmedPasswordChanged>(_onGetConfirmedPasswordChanged, transformer: Transformer.throttleDebounce());
    on<GetAccountCreationRequested>(_onGetAccountCreationRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onGetNameChanged(GetNameChanged event, Emitter<RegisterState> emit) {
    final name = NameFormzModel.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([name, state.email, state.password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetEmailChanged(GetEmailChanged event, Emitter<RegisterState> emit) {
    final email = EmailFormzModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, email, state.password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetPasswordChanged(GetPasswordChanged event, Emitter<RegisterState> emit) {
    final password = PasswordFormzModel.dirty(PasswordParameters(
      isPasswordField: true,
      password: event.passWord,
      confirmPassword: event.confirmPassWord,
    ));
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, state.email, password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetConfirmedPasswordChanged(GetConfirmedPasswordChanged event, Emitter<RegisterState> emit) {
    final confirmedPassword = PasswordFormzModel.dirty(PasswordParameters(
      isPasswordField: false,
      password: event.passWord,
      confirmPassword: event.confirmPassWord,
    ));
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, state.email, state.password, confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetAccountCreationRequested(GetAccountCreationRequested event, Emitter<RegisterState> emit) async {
    if (state.status == FormzSubmissionStatus.failure) {
      emit(state.copyWith(
        isValid: Formz.validate([state.name, state.email, state.password, state.confirmedPassword]),
      ));
    }

    if (state.status == FormzSubmissionStatus.initial || !state.isValid) {
      final name = NameFormzModel.dirty(state.name.value);
      final email = EmailFormzModel.dirty(state.email.value);
      final password = PasswordFormzModel.dirty(state.password.value);
      final confirmedPassword = PasswordFormzModel.dirty(state.confirmedPassword.value);

      emit(state.copyWith(
        name: name,
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([name, email, password, confirmedPassword]),
      ));
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      RegisterDetailsParam registerDetailsParam = RegisterDetailsParam(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value.password,
        passwordConfirmation: state.confirmedPassword.value.confirmPassword,
      );

      debugPrint('RegisterDetailsParam --> $registerDetailsParam');
      Either<Failure, LoginEntity> result = await registerUseCase(registerDetailsParam);
      result.fold(
        (failure) {
          String message = '';
          if (failure is ServerFailure) {
            message = failure.message;
          } else if (failure is NoConnectionFailure) {
            message = 'Please check your internet connection and try again!';
          } else {
            message = 'Something went wrong. Please try again later!';
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
}

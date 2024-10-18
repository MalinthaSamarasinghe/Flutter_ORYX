import '../../../injector.dart';
import 'bloc/register_bloc.dart';
import '../../../utils/font.dart';
import 'package:formz/formz.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/presentation/custom_snack_bar.dart';
import '../../../core/blocs/authentication/auth_bloc.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/models/form_inputs/name_form_model.dart';
import '../../../core/models/form_inputs/email_formz_model.dart';
import '../../../core/presentation/buttons/socal_media_button.dart';
import '../../../core/models/form_inputs/password_formz_model.dart';
import '../../../core/presentation/textfields/login_textfield.dart';

class RegisterScreenWrapper extends StatelessWidget {
  const RegisterScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => sl<RegisterBloc>(),
        ),
      ],
      child: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPortrait = true;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: OrientationBuilder(
              builder: (context, orientation) {
                /// Changes to apply based on orientation
                isPortrait = orientation == Orientation.portrait;
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: kColorWhite,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: isPortrait ? 140 : 40),
                        /// Welcome to ORYX Text
                        AutoSizeText(
                          "Welcome to ORYX",
                          style: kInter600(context, fontSize: 30),
                          textAlign: TextAlign.center,
                          minFontSize: 30,
                          maxLines: 2,
                        ),
                        SizedBox(height: isPortrait ? 10 : 5),
                        /// Sign Up Text
                        AutoSizeText(
                          "Sign Up",
                          style: kInter600(context, fontSize: 24),
                          textAlign: TextAlign.center,
                          minFontSize: 24,
                          maxLines: 2,
                        ),
                        SizedBox(height: isPortrait ? 10 : 5),
                        /// You can Sign Up now or continue with Google / Facebook / Twitter Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AutoSizeText(
                            "You can Sign Up now or continue with Google / Facebook / Twitter",
                            style: kInter600(context, fontSize: 14),
                            textAlign: TextAlign.center,
                            minFontSize: 14,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        /// User Name TextField
                        BlocSelector<RegisterBloc, RegisterState, NameFormzModel>(
                          selector: (state) {
                            return state.name;
                          },
                          builder: (context, userName) {
                            return LoginTextField(
                              hint: "Name",
                              prefixIcon: "assets/svg/user.svg",
                              textController: context.read<RegisterBloc>().nameController,
                              focusNode: context.read<RegisterBloc>().nameNode,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              autofillHints: const [AutofillHints.username],
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                context.read<RegisterBloc>().add(GetNameChanged(text.trim()));
                              },
                              onSubmitted: (text) {
                                FocusScope.of(context).requestFocus(context.read<RegisterBloc>().emailNode);
                              },
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: userName.isValid,
                              errorText: userName.isPure ? null : userName.error?.message,
                            );
                          },
                        ),
                        /// User Email TextField
                        BlocSelector<RegisterBloc, RegisterState, EmailFormzModel>(
                          selector: (state) {
                            return state.email;
                          },
                          builder: (context, userEmail) {
                            return LoginTextField(
                              hint: "Email",
                              prefixIcon: "assets/svg/user.svg",
                              textController: context.read<RegisterBloc>().emailController,
                              focusNode: context.read<RegisterBloc>().emailNode,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                context.read<RegisterBloc>().add(GetEmailChanged(text.trim()));
                              },
                              onSubmitted: (text) {
                                FocusScope.of(context).requestFocus(context.read<RegisterBloc>().passwordNode);
                              },
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: userEmail.isValid,
                              errorText: userEmail.isPure ? null : userEmail.error?.message,
                            );
                          },
                        ),
                        /// Password TextField
                        BlocSelector<RegisterBloc, RegisterState, PasswordFormzModel>(
                          selector: (state) {
                            return state.password;
                          },
                          builder: (context, password) {
                            return LoginTextField(
                              hint: "Password",
                              prefixIcon: "assets/svg/lock.svg",
                              textController: context.read<RegisterBloc>().passwordController,
                              focusNode: context.read<RegisterBloc>().passwordNode,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.next,
                              isPassword: true,
                              onChanged: (text) {
                                context.read<RegisterBloc>().add(GetPasswordChanged(text.trim(), context.read<RegisterBloc>().confirmedPasswordController.text.trim()));
                                if(context.read<RegisterBloc>().confirmedPasswordController.text != ''){
                                  context.read<RegisterBloc>().add(GetConfirmedPasswordChanged(context.read<RegisterBloc>().confirmedPasswordController.text.trim(), text.trim()));
                                }
                              },
                              onSubmitted: (text) {
                                FocusScope.of(context).requestFocus(context.read<RegisterBloc>().confirmedPasswordNode);
                              },
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: password.isValid,
                              errorText: password.isPure ? null : password.error?.message,
                            );
                          },
                        ),
                        /// Confirm Password TextField
                        BlocSelector<RegisterBloc, RegisterState, PasswordFormzModel>(
                          selector: (state) {
                            return state.password;
                          },
                          builder: (context, confirmedPassword) {
                            return LoginTextField(
                              hint: "Confirm Password",
                              prefixIcon: "assets/svg/lock.svg",
                              textController: context.read<RegisterBloc>().confirmedPasswordController,
                              focusNode: context.read<RegisterBloc>().confirmedPasswordNode,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.done,
                              isPassword: true,
                              onChanged: (text) {
                                context.read<RegisterBloc>().add(GetConfirmedPasswordChanged(text.trim(), context.read<RegisterBloc>().passwordController.text.trim()));
                                if(context.read<RegisterBloc>().passwordController.text != ''){
                                  context.read<RegisterBloc>().add(GetPasswordChanged(context.read<RegisterBloc>().passwordController.text.trim(), text.trim()));
                                }
                              },
                              onSubmitted: (text) {},
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: confirmedPassword.isValid,
                              errorText: confirmedPassword.isPure ? null : confirmedPassword.error?.message,
                            );
                          },
                        ),
                        /// SignUp Button
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state.status == FormzSubmissionStatus.inProgress) {
                              EasyLoading.show(status: "Please Wait", dismissOnTap: false);
                            }
                            if (state.status == FormzSubmissionStatus.failure) {
                              EasyLoading.dismiss();
                              Future.delayed(const Duration(milliseconds: 100), () {
                                CustomSnackBar().showSnackBar(
                                  context,
                                  msg: state.errorMessage ?? "Something went wrong. Please try again later!",
                                  snackBarTypes: SnackBarTypes.error,
                                );
                              });
                            }
                            if (state.status == FormzSubmissionStatus.success) {
                              EasyLoading.dismiss();
                              context.read<AuthBloc>().add(LoggedIn(authenticationStatus: AuthStatus.authenticated, loginEntity: state.loginEntity!));
                            }
                          },
                          builder: (context, state) {
                            return MainButton(
                              title: "Sign Up",
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                context.read<RegisterBloc>().add(const GetAccountCreationRequested());
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        /// Social Media Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Google Button
                            SocialMediaButton(
                              icon: "assets/svg/google_icon.svg",
                              press: () {
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  CustomSnackBar().showSnackBar(
                                    context,
                                    msg: "Google Sign In is not available yet!",
                                    snackBarTypes: SnackBarTypes.error,
                                  );
                                });
                              },
                            ),
                            /// Facebook Button
                            SocialMediaButton(
                              icon: "assets/svg/facebook_icon.svg",
                              press: () {
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  CustomSnackBar().showSnackBar(
                                    context,
                                    msg: "Facebook Sign In is not available yet!",
                                    snackBarTypes: SnackBarTypes.error,
                                  );
                                });
                              },
                            ),
                            /// Twitter Button
                            SocialMediaButton(
                              icon: "assets/svg/twitter_icon.svg",
                              press: () {
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  CustomSnackBar().showSnackBar(
                                    context,
                                    msg: "Twitter Sign In is not available yet!",
                                    snackBarTypes: SnackBarTypes.error,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        /// Already have an account? Sign In Text Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "Already have an account?  ",
                              style: kInter500(context, fontSize: 14),
                              textAlign: TextAlign.center,
                              minFontSize: 14,
                              maxLines: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: AutoSizeText(
                                "Sign In",
                                style: kInter500(context, fontSize: 14, decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                                minFontSize: 14,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isPortrait ? 20 : 50),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}

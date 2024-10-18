import 'bloc/login_bloc.dart';
import '../../../injector.dart';
import 'package:formz/formz.dart';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../register/presentation/register_screen.dart';
import '../../../core/presentation/custom_snack_bar.dart';
import '../../../core/blocs/authentication/auth_bloc.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/models/form_inputs/email_formz_model.dart';
import '../../../core/models/form_inputs/common_formz_model.dart';
import '../../../core/presentation/buttons/socal_media_button.dart';
import '../../../core/presentation/textfields/login_textfield.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
      ],
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool isPortrait = true;

  @override
  void initState() {
    context.read<LoginBloc>().userEmailController.text = context.read<LoginBloc>().state.email.value;
    context.read<LoginBloc>().userPasswordController.text = context.read<LoginBloc>().state.password.value;
    isChecked = context.read<LoginBloc>().state.rememberMe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
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
                        SizedBox(height: isPortrait ? 160 : 40),
                        /// Welcome to ORYX Text
                        AutoSizeText(
                          "Welcome to ORYX",
                          style: kInter600(context, fontSize: 30),
                          textAlign: TextAlign.center,
                          minFontSize: 30,
                          maxLines: 2,
                        ),
                        SizedBox(height: isPortrait ? 10 : 5),
                        /// Sign In Text
                        AutoSizeText(
                          "Sign In",
                          style: kInter600(context, fontSize: 24),
                          textAlign: TextAlign.center,
                          minFontSize: 24,
                          maxLines: 2,
                        ),
                        SizedBox(height: isPortrait ? 10 : 5),
                        /// You can Sign In now or continue with Google / Facebook / Twitter Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AutoSizeText(
                            "You can Sign In now or continue with Google / Facebook / Twitter",
                            style: kInter600(context, fontSize: 14),
                            textAlign: TextAlign.center,
                            minFontSize: 14,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        /// Email TextField
                        BlocSelector<LoginBloc, LoginState, EmailFormzModel>(
                          selector: (state) {
                            return state.email;
                          },
                          builder: (context, email) {
                            return LoginTextField(
                              hint: "Email",
                              prefixIcon: "assets/svg/user.svg",
                              textController: context.read<LoginBloc>().userEmailController,
                              focusNode: context.read<LoginBloc>().userEmailNode,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                context.read<LoginBloc>().add(EmailChanged(text.trim()));
                              },
                              onSubmitted: (text) {
                                FocusScope.of(context).requestFocus(context.read<LoginBloc>().userPasswordNode);
                              },
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: email.isValid,
                              errorText: email.isPure ? null : email.error?.message,
                            );
                          },
                        ),
                        /// Password TextField
                        BlocSelector<LoginBloc, LoginState, CommonFormzModel>(
                          selector: (state) {
                            return state.password;
                          },
                          builder: (context, password) {
                            return LoginTextField(
                              hint: "Password",
                              prefixIcon: "assets/svg/lock.svg",
                              textController: context.read<LoginBloc>().userPasswordController,
                              focusNode: context.read<LoginBloc>().userPasswordNode,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.done,
                              isPassword: true,
                              onChanged: (text) {
                                context.read<LoginBloc>().add(PasswordChanged(text.trim()));
                              },
                              onSubmitted: (text) {},
                              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              isValid: password.isValid,
                              errorText: password.isPure
                                  ? null
                                  : password.error?.type == CommonValidationErrorType.empty
                                  ? "Password shouldn't be empty!"
                                  : null,
                            );
                          },
                        ),
                        /// Check Box
                        Padding(
                          padding: const EdgeInsets.only(right: 44),
                          child: GestureDetector(
                            onTap: (){
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              setState(() {
                                isChecked = !isChecked;
                              });
                              context.read<LoginBloc>().add(RememberMeTapped(isRemember: isChecked));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  isChecked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                                  color: kColorBlack,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  constraints: const BoxConstraints(maxWidth: 92),
                                  child: AutoSizeText(
                                    "Remember Me",
                                    style: kInter500(context, fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    minFontSize: 12,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        /// SignIn Button
                        BlocConsumer<LoginBloc, LoginState>(
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
                              title: "Sign In",
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                context.read<LoginBloc>().add(const PasswordLoginRequested());
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
                        /// Don't have an account? Sign Up Text Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "Don’t have an account?  ",
                              style: kInter500(context, fontSize: 14),
                              textAlign: TextAlign.center,
                              minFontSize: 14,
                              maxLines: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreenWrapper()));
                              },
                              child: AutoSizeText(
                                "Sign Up",
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
      ),
    );
  }
}

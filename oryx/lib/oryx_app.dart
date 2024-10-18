import 'injector.dart';
import 'utils/colors.dart';
import 'package:flutter/material.dart';
import 'features/bottom_nav/bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/custom_snack_bar.dart';
import 'core/blocs/authentication/auth_bloc.dart';
import 'features/login/presentation/login_screen.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class OryxAppWrapper extends StatelessWidget {
  const OryxAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
      ],
      child: const OryxApp(),
    );
  }
}

class OryxApp extends StatefulWidget {
  const OryxApp({super.key});

  @override
  State<OryxApp> createState() => _OryxAppState();
}

class _OryxAppState extends State<OryxApp> {
  bool navigatedToNextScreen = false;

  @override
  Widget build(BuildContext context) {
    /// Remove the splash screen
    FlutterNativeSplash.remove();
    return MaterialApp(
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return ScrollConfiguration(
          behavior: AppBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: "Oryx",
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(kColorDarkBlue),
          thickness: WidgetStateProperty.all(4),
          radius: const Radius.circular(4),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kColorBlack,
          selectionColor: kColorBlack.withOpacity(0.3),
          selectionHandleColor: kColorBlack.withOpacity(0.9),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          _authListener(context, state);
        },
        listenWhen: (previous, current) {
          return previous.authenticationStatus != current.authenticationStatus;
        },
        buildWhen: (previous, current) {
          return !navigatedToNextScreen;
        },
        builder: (context, state) {
          return _getNavigateNextScreen(context);
        },
      ),
    );
  }

  /// Navigate to next screen base on user authentication
  Widget _getNavigateNextScreen(BuildContext context) {
    navigatedToNextScreen = true;
    switch (context.read<AuthBloc>().state.authenticationStatus) {
      case AuthStatus.authenticated:
        return const BottomNavBarWrapper(selectedIndex: 0);
      default:
        return const LoginScreenWrapper();
    }
  }

  /// User will redirect to the login screen when the user session expired or user logout
  Future<void> _authListener(BuildContext context, AuthState state) async {
    switch (state.authenticationStatus) {
      case AuthStatus.authenticated:
        {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBarWrapper(selectedIndex: 0)), (route) => route.isFirst,
          );
        }
        break;
      case AuthStatus.unauthenticated:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
        }
        break;
      case AuthStatus.sessionExpired:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomSnackBar().showSnackBar(
              context,
              msg: "Session expired. Please log in again!",
              snackBarTypes: SnackBarTypes.error,
            );
          });
        }
        break;
      case AuthStatus.logOutInProgress:
        {
          EasyLoading.show(status: "Please Wait", dismissOnTap: false);
        }
        break;
      default:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomSnackBar().showSnackBar(
              context,
              msg: "Something went wrong. Please try again later!",
              snackBarTypes: SnackBarTypes.error,
            );
          });
        }
    }
  }
}

/// To remove scroll glow
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

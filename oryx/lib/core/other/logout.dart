import 'package:flutter/material.dart';
import '../presentation/alert_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/auth_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';

logOut(BuildContext context) {
  Alerts.getInstance().twoButtonAlert(
    context,
    // Translate the message
    title: "Log Out",
    msg: "Are you sure you want to log out? You will need to sign back in to continue.",
    btnNoText: "Cancel",
    btnYesText: "Log Out",
    functionNo:() {
      Navigator.pop(context);
    },
    functionYes:() {
      _logout(context);
    },
  );
}

_logout(BuildContext context) async {
  Navigator.of(context).pop();

  /// Need to preserve isRemember value even after HydratedStorage cleared
  final bool isRemember = BlocProvider.of<LoginBloc>(context).state.rememberMe;

  _applyLogoutConfigs().then((value) async {
    context.read<AuthBloc>().add(const LoggedOut());

    /// Set isRemember value again
    BlocProvider.of<LoginBloc>(context).add(RememberMeTapped(isRemember: isRemember));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  });
}

Future _applyLogoutConfigs() async {
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  /// Clear all preserved hydrated bloc states
  await storage.clear();
}

import '../../utils/colors.dart';
import '../../core/other/logout.dart';
import 'package:flutter/material.dart';
import 'widgets/setting_menu_card.dart';
import 'package:provider/provider.dart';
import '../../core/other/theme_notifier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../profile/presentation/profile_screen.dart';
import '../../core/presentation/screen_app_bar.dart';
import '../../core/presentation/custom_snack_bar.dart';
import '../profile/presentation/bloc/current_location/current_location_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final String name;
  final String email;
  final String batteryState;
  final String batteryLevel;
  final void Function()? onLeadingPressCallback;

  const SettingsScreen({
    super.key,
    required this.name,
    required this.email,
    required this.batteryState,
    required this.batteryLevel,
    this.onLeadingPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool value = themeNotifier.isDarkMode;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        backgroundColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
        appBar: ScreenAppBar(
          color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack,
          hasTitle: true,
          title: "Settings",
          statusBarType: themeNotifier.isDarkMode ? StatusBarType.light : StatusBarType.dark,
          leadingType: LeadingType.back,
          trailingType: TrailingType.none,
          onLeadingPress: () {
            FocusManager.instance.primaryFocus?.unfocus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            onLeadingPressCallback?.call();
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              /// My Account
              SettingMenuCard(
                title: "My Account",
                icon: Icons.supervisor_account_rounded,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<CurrentLocationBloc>(context),
                          child: ProfileScreen(
                            name: name,
                            email: email,
                            batteryLevel: batteryLevel,
                            batteryState: batteryState,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              /// Notifications
              SettingMenuCard(
                title: "Notifications",
                icon: Icons.notifications_active_rounded,
                onPress: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    CustomSnackBar().showSnackBar(
                      context,
                      msg: "Notifications are not available yet.",
                      snackBarTypes: SnackBarTypes.error,
                    );
                  });
                },
              ),
              /// Settings
              SettingMenuCard(
                title: "Dark Mode",
                icon: themeNotifier.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                onPress: () {
                  themeNotifier.setTheme(!value);
                },
              ),
              /// Help Center
              SettingMenuCard(
                title: "Get Help",
                icon: Icons.live_help_rounded,
                onPress: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    CustomSnackBar().showSnackBar(
                      context,
                      msg: "Help Center is not available yet.",
                      snackBarTypes: SnackBarTypes.error,
                    );
                  });
                },
              ),
              /// Log Out
              SettingMenuCard(
                title: "Log Out",
                icon: Icons.logout_rounded,
                onPress: () async {
                  await logOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

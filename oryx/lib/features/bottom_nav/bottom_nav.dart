import 'dart:io';
import '../../injector.dart';
import 'widget/nav_icon.dart';
import '../../utils/font.dart';
import '../../utils/colors.dart';
import '../home/home_screen.dart';
import '../cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings/settings_screen.dart';
import '../../core/other/theme_notifier.dart';
import '../cart/presentation/cart_screen.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../products/presentation/products_screen.dart';
import '../../core/blocs/authentication/auth_bloc.dart';
import '../products/presentation/bloc/product_bloc.dart';
import '../profile/presentation/bloc/current_location/current_location_bloc.dart';

class BottomNavBarWrapper extends StatelessWidget {
  final int? selectedIndex;

  const BottomNavBarWrapper({super.key, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => sl<ProductBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>(),
        ),
        BlocProvider<CurrentLocationBloc>(
          create: (context) => sl<CurrentLocationBloc>(),
        ),
      ],
      child: BottomNavBar(selectedIndex: selectedIndex),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final int? selectedIndex;

  const BottomNavBar({super.key, this.selectedIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int? _selectedIndex = widget.selectedIndex;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var battery = Battery();
  String batteryState = "Unknown";
  String batteryLevel = "0%";
  String name = "";
  String email = "";

  void _onItemTapped(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    context.read<ProductBloc>().add(const InitialProductListEvent());
    checkBattery();
    /// Be informed when the state (full, charging, discharging) changes
    battery.onBatteryStateChanged.listen((BatteryState state) {
      switch (state) {
        case BatteryState.full:
          batteryState = "Full";
          break;
        case BatteryState.charging:
          batteryState = "Charging";
          break;
        case BatteryState.discharging:
          batteryState = "Discharging";
          break;
        case BatteryState.connectedNotCharging:
          batteryState = "Connected Not Charging";
          break;
        case BatteryState.unknown:
          batteryState = "Unknown";
          break;
      }
    });
    name = context.read<AuthBloc>().state.loginEntity?.user?.name ?? "";
    email = context.read<AuthBloc>().state.loginEntity?.user?.email ?? "";
    super.initState();
  }

  /// Access current battery level
  void checkBattery() async {
    batteryLevel = "${await battery.batteryLevel}%";
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    /// Initialize the widget options here, where `_onItemTapped` is accessible.
    final List<Widget> widgetOptions = <Widget>[
      HomeScreen(onLeadingPressCallback: () => _onItemTapped(1)),
      ProductsScreen(onLeadingPressCallback: () => _onItemTapped(0)),
      CartScreen(onLeadingPressCallback: () => _onItemTapped(0)),
      SettingsScreen(
        onLeadingPressCallback: () => _onItemTapped(0),
        name: name,
        email: email,
        batteryState: batteryState,
        batteryLevel: batteryLevel,
      ),
    ];
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: Center(child: widgetOptions.elementAt(_selectedIndex!)),
          bottomNavigationBar: SizedBox(
            height: Platform.isAndroid ? 84 : 106,
            child: BottomNavigationBar(
              backgroundColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
              items: <BottomNavigationBarItem>[
                /// POS (_selectedIndex == 0)
                BottomNavigationBarItem(
                  activeIcon: const NavBarIcon(
                    icon: Icons.home,
                    iconColor: kColorLightBlue,
                  ),
                  icon: NavBarIcon(
                    icon: Icons.home,
                    iconColor: themeNotifier.isDarkMode ? kColorWhite : kNavIconColor,
                  ),
                  // Translate the message
                  label: "Home",
                ),
                /// Scan (_selectedIndex == 1)
                BottomNavigationBarItem(
                  activeIcon: const NavBarIcon(
                    icon: Icons.gif_box_rounded,
                    iconColor: kColorLightBlue,
                  ),
                  icon: NavBarIcon(
                    icon: Icons.gif_box_rounded,
                    iconColor: themeNotifier.isDarkMode ? kColorWhite : kNavIconColor,
                  ),
                  // Translate the message
                  label: "Product",
                ),
                /// Product (_selectedIndex == 2)
                BottomNavigationBarItem(
                  activeIcon: const NavBarIcon(
                    icon: Icons.shopping_cart,
                    iconColor: kColorLightBlue,
                  ),
                  icon: NavBarIcon(
                    icon: Icons.shopping_cart,
                    iconColor: themeNotifier.isDarkMode ? kColorWhite : kNavIconColor,
                  ),
                  // Translate the message
                  label: "Cart",
                ),
                /// Customer (_selectedIndex == 3)
                BottomNavigationBarItem(
                  activeIcon: const NavBarIcon(
                    icon: Icons.settings,
                    iconColor: kColorLightBlue,
                  ),
                  icon: NavBarIcon(
                    icon: Icons.settings,
                    iconColor: themeNotifier.isDarkMode ? kColorWhite : kNavIconColor,
                  ),
                  // Translate the message
                  label: "Settings",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kColorLightBlue,
              selectedLabelStyle: kInter600(context, fontSize: 10),
              unselectedItemColor: themeNotifier.isDarkMode ? kColorWhite : kFontColor,
              unselectedLabelStyle: kInter600(context, fontSize: 10),
              currentIndex: _selectedIndex!,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

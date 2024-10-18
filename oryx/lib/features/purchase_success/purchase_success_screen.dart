import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import '../bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/other/theme_notifier.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/presentation/buttons/main_button.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  const PurchaseSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Scaffold(
          backgroundColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/done_filled_circle.svg",
                    height: 115,
                    width: 115,
                    colorFilter: const ColorFilter.mode(kColorGreen, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 32),
                  AutoSizeText(
                    "Purchase Successful",
                    style: kInter600(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 20),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 20,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 30),
                  MainButton(
                    title: "Back to Home",
                    titleColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
                    margin: EdgeInsets.zero,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const BottomNavBarWrapper(selectedIndex: 0);
                          },
                        ),
                        (route) => route.isFirst,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

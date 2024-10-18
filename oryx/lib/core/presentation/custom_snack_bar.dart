import '../../utils/font.dart';
import '../../utils/colors.dart';
import '../other/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomSnackBar {
  showSnackBar(
    BuildContext context, {
    required String msg,
    required SnackBarTypes snackBarTypes,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      width: double.infinity,
      content: CustomSnackBarContent(
        message: msg,
        snackBarTypes: snackBarTypes,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class CustomSnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarTypes snackBarTypes;

  const CustomSnackBarContent({
    super.key,
    required this.message,
    required this.snackBarTypes,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(26, 0, 26, 15),
      padding: const EdgeInsets.fromLTRB(14, 12, 9, 12),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: snackBarTypes.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            offset: Offset(0, 4),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            snackBarTypes.prefixIcon,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(themeNotifier.isDarkMode ? kColorBlack : snackBarTypes.iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 11),
          Container(
            constraints: const BoxConstraints(maxWidth: 255),
            child: AutoSizeText(
              message,
              style: kInter500(context, color: themeNotifier.isDarkMode ? kColorBlack : snackBarTypes.iconColor, fontSize: 12),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              minFontSize: 12,
              maxLines: 2,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: SvgPicture.asset(
              snackBarTypes.suffixIcon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(themeNotifier.isDarkMode ? kColorBlack : snackBarTypes.iconColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

class SnackBarTypes {
  final String prefixIcon;
  final String suffixIcon;
  final Color iconColor;
  final Color backgroundColor;

  SnackBarTypes(this.prefixIcon, this.suffixIcon, this.iconColor, this.backgroundColor);

  static SnackBarTypes error = SnackBarTypes("assets/svg/warning.svg", "assets/svg/close.svg", kColorWhite, kColorSnackBar);
  static SnackBarTypes alert = SnackBarTypes("assets/svg/warning.svg", "assets/svg/close.svg", kColorBlack, kColorWhite);
  static SnackBarTypes success = SnackBarTypes("assets/svg/done_filled_circle.svg", "assets/svg/close.svg", kColorWhite, kColorGreen);
}

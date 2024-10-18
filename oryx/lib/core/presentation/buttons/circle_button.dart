import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CircleButton extends StatelessWidget {
  final double buttonSize;
  final String icon;
  final double iconSize;
  final Function()? onTap;
  final Decoration? btnDecoration;
  final String title;

  const CircleButton({
    super.key,
    this.buttonSize = 63,
    required this.icon,
    this.iconSize = 40,
    this.onTap,
    this.btnDecoration,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: btnDecoration ?? const BoxDecoration(
              shape: BoxShape.circle,
              color: kColorFieldBorder,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: iconSize,
                height: iconSize,
                colorFilter: const ColorFilter.mode(kColorBlack, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: buttonSize,
            child: AutoSizeText(
              title,
              style: kInter500(context, fontSize: 14),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              minFontSize: 14,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

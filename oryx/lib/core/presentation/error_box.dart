import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ErrorBox extends StatelessWidget {
  final AlignmentGeometry alignment;
  final String? title;
  final TextStyle? titleStyle;
  final String svgImage;
  final int svgSize;
  final EdgeInsets? innerPadding;
  final EdgeInsets? outerPadding;
  final Color? bgColor;
  final int radius;
  final double? height;

  const ErrorBox({
    super.key,
    this.title = "",
    this.alignment = Alignment.topCenter,
    this.titleStyle,
    this.svgImage = "assets/svg/error_filled.svg",
    this.svgSize = 20,
    this.innerPadding,
    this.outerPadding,
    this.bgColor,
    this.radius = 10,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: double.infinity,
        height: height,
        margin: outerPadding ?? EdgeInsets.zero,
        padding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 47, vertical: 28),
        decoration: BoxDecoration(
          color: bgColor ?? kFontFieldHintColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(radius.toDouble()),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: height != null ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(svgImage, width: svgSize.toDouble(), height: svgSize.toDouble()),
            title == null || title!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AutoSizeText(
                      title!,
                      style: titleStyle ?? kInter500(context, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      minFontSize: 15,
                      maxLines: 2,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainButton extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final bool hasBoxShadow;
  final bool hasBorderColor;
  final double? borderRadius;
  final Color? borderColor;
  final String? title;
  final TextStyle? titleStyle;
  final double titleSize;
  final Color? titleColor;
  final Function() onPressed;
  final bool isInProgress;
  final bool hasIcon;
  final String? icon;
  final int iconSize;
  final Color iconColor;
  final MainButtonType buttonType;

  const MainButton({
    super.key,
    this.height,
    this.margin,
    this.backgroundColor = kColorLightBlue,
    this.hasBoxShadow = false,
    this.hasBorderColor = false,
    this.borderRadius,
    this.borderColor,
    this.title,
    this.titleStyle,
    this.titleSize = 16,
    this.titleColor,
    required this.onPressed,
    this.isInProgress = false,
    this.hasIcon = false,
    this.icon,
    this.iconSize = 8,
    this.iconColor = kColorWhite,
    this.buttonType = MainButtonType.primaryType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 54,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        border: hasBorderColor
            ? Border.all(width: 1, color: borderColor ?? backgroundColor)
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 27),
        color: backgroundColor,
        boxShadow: hasBoxShadow
            ? [
                const BoxShadow(
                  color: kShadowColor,
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(borderRadius ?? 27),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: isInProgress
                ? Platform.isAndroid
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(color: kColorBlack, strokeWidth: 3),
                      )
                    : const CupertinoActivityIndicator(radius: 10)
                : buttonType == MainButtonType.primaryType
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            hasIcon
                                ? Padding(
                                    padding: EdgeInsets.only(right: iconSize != 8 ? 8 : 4),
                                    child: SizedBox(
                                      height: iconSize.toDouble(),
                                      width: iconSize.toDouble(),
                                      child: SvgPicture.asset(
                                        icon ?? "assets/svg/add.svg",
                                        height: iconSize.toDouble(),
                                        width: iconSize.toDouble(),
                                        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            AutoSizeText(
                              title!,
                              style: titleStyle ?? kInter500(context, color: titleColor ?? kColorWhite, fontSize: titleSize),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: titleSize,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              title!,
                              style: titleStyle ?? kInter500(context, color: titleColor ?? kColorWhite, fontSize: titleSize),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: titleSize,
                              maxLines: 1,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 23,
                              width: 23,
                              margin: const EdgeInsets.only(right: 3),
                              decoration: const BoxDecoration(
                                color: kColorWhite,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  icon ?? "assets/svg/add.svg",
                                  height: iconSize.toDouble(),
                                  width: iconSize.toDouble(),
                                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}

enum MainButtonType { primaryType, posType }

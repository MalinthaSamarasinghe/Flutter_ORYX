import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchField extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final String hint;
  final TextEditingController textController;
  final FocusNode? focusNode;
  final bool isEnabled;
  final void Function(String text)? onSearched;
  final void Function()? onClear;
  final void Function(String text)? onSubmitted;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final void Function()? onTap;
  final String? prefixIcon;
  final Color? prefixIconFillColor;
  final Color? backgroundColor;
  final Color borderColor;
  final bool? autofocus;

  const SearchField({
    super.key,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
    required this.hint,
    required this.textController,
    this.focusNode,
    this.isEnabled = true,
    this.onSearched,
    this.onSubmitted,
    this.onClear,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatter,
    this.onTap,
    this.prefixIcon,
    this.prefixIconFillColor,
    this.backgroundColor = kColorTextField,
    this.borderColor = kColorTextField,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    var autofocused = false;
    if (autofocus == true) {
      autofocused = true;
    }

    return Container(
      height: (height ?? 54),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 27),
        border: Border.all(color: borderColor),
        color: backgroundColor,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: TextFormField(
            enabled: isEnabled,
            controller: textController,
            focusNode: focusNode,
            textCapitalization: textCapitalization,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            inputFormatters: inputFormatter,
            onTap: onTap,
            onChanged: (text) {
              if (onSearched != null) {
                onSearched!(text);
              }
            },
            autofocus: autofocused,
            onFieldSubmitted: onSubmitted,
            textAlignVertical: TextAlignVertical.center,
            style: kInter400(context, fontSize: 15),
            cursorColor: kColorBlack,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: kInter400(context, color: kFontHintColor, fontSize: 14),
              prefixIcon: prefixIcon != null
                  ? prefixIcon!.endsWith('.svg')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: SvgPicture.asset(
                            prefixIcon!,
                            width: 19,
                            height: 19,
                            colorFilter: ColorFilter.mode(prefixIconFillColor ?? kColorIcon, BlendMode.srcIn),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Image.asset(
                            prefixIcon!,
                            width: 19,
                            height: 19,
                            color: prefixIconFillColor ?? kColorIcon,
                          ),
                        )
                  : null,
              suffixIcon: textController.text != ""
                  ? GestureDetector(
                      onTap: () {
                        if (onClear != null) {
                          onClear!();
                        }
                        textController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8, 13, 12, 13),
                        child: Text(
                          "Clear",
                          style: kInter400(context, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

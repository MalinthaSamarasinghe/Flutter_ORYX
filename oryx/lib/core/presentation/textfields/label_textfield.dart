import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LabelTextField extends StatefulWidget {
  final double? height;
  final double? fieldHeight;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? textFieldMargin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final String hint;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController textController;
  final FocusNode? focusNode;
  final bool isEnabled;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final bool? isValid;
  final String? errorText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final Color? prefixIconFillColor;
  final Color? backgroundColor;
  final Color borderColor;
  final LabelIconType? labelIconType;
  final TextAlign textAlign;

  const LabelTextField({
    super.key,
    this.height,
    this.fieldHeight,
    this.margin,
    this.textFieldMargin,
    this.padding,
    this.borderRadius,
    required this.hint,
    this.label,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    required this.textController,
    this.focusNode,
    this.isEnabled = true,
    this.onChanged,
    this.onSubmitted,
    this.isValid,
    this.errorText,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatter,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconFillColor,
    this.backgroundColor = kColorWhite,
    this.borderColor = kColorFieldBorder,
    this.labelIconType = LabelIconType.none,
    this.textAlign = TextAlign.start,
  });

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  bool isValid = false;

  @override
  void initState() {
    if (widget.isValid != null) {
      isValid = widget.isValid!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LabelTextField oldWidget) {
    if (widget.isValid != oldWidget.isValid) {
      isValid = widget.isValid!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.height ?? 78),
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 26),
      child: Stack(
        children: [
          /// TextField
          Container(
            height: (widget.fieldHeight ?? 40),
            margin: widget.textFieldMargin ?? const EdgeInsets.only(top: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
              border: Border.all(
                color: widget.height == null
                    ? widget.errorText == null
                        ? widget.borderColor
                        : kColorRed
                    : widget.borderColor
              ),
              color: widget.backgroundColor,
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: TextFormField(
                        enabled: widget.isEnabled,
                        controller: widget.textController,
                        focusNode: widget.focusNode,
                        textCapitalization: widget.textCapitalization,
                        keyboardType: widget.keyboardType,
                        autofillHints: widget.autofillHints,
                        textInputAction: widget.textInputAction,
                        inputFormatters: widget.inputFormatter,
                        onChanged: (text) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(text);
                          }
                        },
                        onFieldSubmitted: widget.onSubmitted,
                        onTap: widget.onTap,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: widget.textAlign,
                        style: widget.textStyle ?? kInter400(context, fontSize: 13),
                        cursorColor: kColorBlack,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.hint,
                          hintStyle: widget.hintStyle ?? kInter400(context, color: kFontFieldHintColor, fontSize: 12),
                          prefixIcon: widget.prefixIcon != null
                              ? widget.prefixIcon!.endsWith('.svg')
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: SvgPicture.asset(
                                        widget.prefixIcon!,
                                        width: 19,
                                        height: 19,
                                        colorFilter: ColorFilter.mode(widget.prefixIconFillColor ?? kColorIcon, BlendMode.srcIn),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Image.asset(
                                        widget.prefixIcon!,
                                        width: 19,
                                        height: 19,
                                        color: widget.prefixIconFillColor ?? kColorIcon,
                                      ),
                                    )
                              : null,
                          suffixIcon: widget.suffixIcon,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// Label Text
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: [
                SizedBox(
                  width: widget.labelIconType == LabelIconType.none ? 130 : 63,
                  child: AutoSizeText(
                    widget.label ?? "",
                    style: widget.labelStyle ?? kInter400(context, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 12,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 3),
                widget.labelIconType == LabelIconType.add
                    ? SvgPicture.asset(
                        "assets/svg/add_circle.svg",
                        width: 12,
                        height: 12,
                      )
                    : widget.labelIconType == LabelIconType.remove
                        ? SvgPicture.asset(
                            "assets/svg/remove_circle.svg",
                            width: 12,
                            height: 12,
                          )
                        : const SizedBox(),
              ],
            ),
          ),
          /// Error Text
          widget.errorText == null
              ? const SizedBox()
              : widget.textFieldMargin == null
                  ? Positioned(
                      bottom: -1,
                      left: 0,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/info.svg",
                            width: 12,
                            height: 12,
                            colorFilter: const ColorFilter.mode(kColorRed, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 2),
                          Container(
                            constraints: BoxConstraints(maxWidth: widget.margin == EdgeInsets.zero ? 142 : 318),
                            child: AutoSizeText(
                              widget.errorText ?? "",
                              style: kInter500(context, color: kColorRed, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 12,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Positioned(
                      bottom: 11,
                      right: 0,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: widget.margin == EdgeInsets.zero ? 142 : 318),
                        child: AutoSizeText(
                          widget.errorText ?? "",
                          style: kInter500(context, color: kColorRed, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 12,
                          maxLines: 1,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

enum LabelIconType { none, add, remove }

import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoginTextField extends StatefulWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final String hint;
  final bool isPassword;
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
  final String? prefixIcon;
  final Color? prefixIconFillColor;
  final Color? backgroundColor;
  final Color borderColor;

  const LoginTextField({
    super.key,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
    required this.hint,
    this.isPassword = false,
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
    this.prefixIcon,
    this.prefixIconFillColor,
    this.backgroundColor = kColorTextField,
    this.borderColor = kColorTextField,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isHidden = true;
  bool isChecked = false;
  bool isValid = false;

  @override
  void initState() {
    if (widget.isValid != null) {
      isValid = widget.isValid!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginTextField oldWidget) {
    if (widget.isValid != oldWidget.isValid) {
      isValid = widget.isValid!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.height ?? 80),
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 26),
      child: Stack(
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 27),
              border: Border.all(color: widget.errorText == null ? widget.borderColor : kColorRed),
              color: widget.backgroundColor,
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.only(left: 8, right: 10),
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
                        style: kInter400(context, fontSize: 15),
                        cursorColor: kColorBlack,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.hint,
                          hintStyle: kInter400(context, color: kFontHintColor, fontSize: 14),
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
                          suffixIcon: widget.isPassword
                              ? InkWell(
                                  onTap: _toggleVisibility,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.5),
                                    child: isHidden
                                        ? Image.asset(
                                            "assets/images/hidden.png",
                                            width: 20,
                                            height: 20,
                                            color: widget.prefixIconFillColor ?? kColorIcon,
                                          )
                                        : Image.asset(
                                            "assets/images/show.png",
                                            width: 20,
                                            height: 20,
                                            color: widget.prefixIconFillColor ?? kColorIcon,
                                          ),
                                  ),
                                )
                              : null,
                        ),
                        obscureText: widget.isPassword ? isHidden : false,
                        obscuringCharacter: "•",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.errorText == null
            ? const SizedBox()
            : Positioned(
                bottom: widget.height == null ? 6 : 2,
                left: 16,
                right: 16,
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
                      constraints: const BoxConstraints(maxWidth: 280),
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
              ),
        ],
      ),
    );
  }

  _toggleVisibility() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      isHidden = !isHidden;
    });
  }
}

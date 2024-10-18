import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasTitle;
  final Color color;
  final StatusBarType statusBarType;
  final LeadingType leadingType;
  final TrailingType trailingType;
  final Function()? onLeadingPress;
  final Function()? onTrailingPress;
  final void Function(String)? onPopupMenuPress;
  final List<Map<String, String>>? trailingMenuItems;

  const ScreenAppBar({
    super.key,
    this.title = "",
    this.hasTitle = false,
    this.color = kColorWhite,
    this.statusBarType = StatusBarType.light,
    this.leadingType = LeadingType.back,
    this.trailingType = TrailingType.none,
    this.onLeadingPress,
    this.onTrailingPress,
    this.onPopupMenuPress,
    this.trailingMenuItems,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: statusBarType == StatusBarType.light ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      title: hasTitle
          ? AutoSizeText(
              title,
              style: kInter600(context, color: color, fontSize: 18),
              overflow: TextOverflow.ellipsis,
              minFontSize: 18,
              maxLines: 1,
            )
          : Image.asset(
              "assets/images/splash_icon.png",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
      leading: leadingType == LeadingType.back
          ? Padding(
              padding: const EdgeInsets.only(left: 21, top: 11, bottom: 11),
              child: InkWell(
                onTap: onLeadingPress,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/back_icon.svg",
                    width: 29,
                    height: 29,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ),
            )
          : leadingType == LeadingType.menu
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15, bottom: 23),
                    child: InkWell(
                      onTap: onLeadingPress,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/menu.svg",
                          width: 20,
                          height: 14,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
      actions: [
        trailingType == TrailingType.share
            ? IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: onTrailingPress,
                color: color,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              )
            : trailingType == TrailingType.more
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: PopupMenuButton<String>(
                        icon: SvgPicture.asset(
                          "assets/svg/action_vertical.svg",
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                        style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.transparent)),
                        tooltip: "",
                        onSelected: onPopupMenuPress,
                        color: kColorWhite,
                        constraints: const BoxConstraints(minWidth: 202, maxWidth: 222),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        clipBehavior: Clip.antiAlias,
                        position: PopupMenuPosition.under,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context) => trailingMenuItems!.map((e) => PopupMenuItem<String>(
                          padding: const EdgeInsets.fromLTRB(18, 10, 12, 10),
                          value: e['value'],
                          height: 20,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 19,
                                height: 19,
                                child: SvgPicture.asset(
                                  e['asset']!,
                                  height: 19,
                                  width: 19,
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 145,
                                child: AutoSizeText(
                                  e['text']!,
                                  style: kInter500(context, fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 15,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }
}

enum StatusBarType { light, dark }

enum LeadingType { none, back, menu }

enum TrailingType { none, more, share }

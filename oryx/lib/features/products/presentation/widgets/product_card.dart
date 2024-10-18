import '../../../../utils/font.dart';
import '../../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/other/convertors.dart';
import '../../../../core/other/theme_notifier.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/presentation/shimmer_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onPress;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GestureDetector(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kColorTextField,
              ),
              clipBehavior: Clip.antiAlias,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  placeholder: (context, url) => shimmerLoader(),
                  errorWidget: (context, url, error) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/svg/default_product.svg",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  useOldImageOnUrlChange: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  name,
                  style: kInter500(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  minFontSize: 14,
                  maxLines: 2,
                ),
                AutoSizeText(
                  stringToRsConvertor(price),
                  style: kInter400(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  minFontSize: 14,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:oryx/utils/colors.dart';

import '../../../utils/font.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String category;
  final String image;
  final int numOfBrands;
  final GestureTapCallback press;
  final bool isDarkMode;

  const OfferCard({
    super.key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: !isDarkMode
                        ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    )
                        : null,
                    color: isDarkMode ? kColorTextField : null,
                  ),
                ),
                Center(child: Image.asset(image, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: kInter600(context, color: isDarkMode ? kColorBlack : kColorWhite, fontSize: 20),
                        ),
                        TextSpan(
                          text: "$numOfBrands Brands",
                          style: kInter500(context, color: isDarkMode ? kColorBlack : kColorWhite, fontSize: 14),
                        ),
                      ],
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

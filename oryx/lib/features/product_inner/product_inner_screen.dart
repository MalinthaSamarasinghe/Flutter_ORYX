import '../../utils/font.dart';
import '../../utils/colors.dart';
import '../cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/Entitty/cart_entity.dart';
import '../../core/other/theme_notifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../core/presentation/screen_app_bar.dart';
import '../../core/presentation/shimmer_builder.dart';
import '../../core/presentation/custom_snack_bar.dart';
import '../products/domain/entity/product_entity.dart';
import '../../core/presentation/buttons/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductInnerScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductInnerScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool isPortrait = true;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        backgroundColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
        appBar: ScreenAppBar(
          color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack,
          hasTitle: true,
          statusBarType: themeNotifier.isDarkMode ? StatusBarType.light : StatusBarType.dark,
          leadingType: LeadingType.back,
          trailingType: TrailingType.none,
          onLeadingPress: () {
            FocusManager.instance.primaryFocus?.unfocus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pop(context);
          },
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            /// Changes to apply based on orientation
            isPortrait = orientation == Orientation.portrait;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if(isPortrait)
                    Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
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
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AutoSizeText(
                            product.name,
                            style: kInter600(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 24),
                            textAlign: TextAlign.center,
                            minFontSize: 24,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  if(!isPortrait)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: product.image,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AutoSizeText(
                            product.name,
                            style: kInter600(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 24),
                            textAlign: TextAlign.center,
                            minFontSize: 24,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AutoSizeText(
                      product.description,
                      style: kInter400(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 14),
                      textAlign: TextAlign.center,
                      minFontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: MainButton(
            title: "Add to Cart",
            titleColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<CartBloc>().add(
                ProductAdded(
                  item: CartEntity(
                    quantity: 1,
                    productId: product.id,
                    productName: product.name,
                    productImage: product.image,
                    productPrice: double.tryParse(product.price) ?? 0.0,
                  ),
                ),
              );
              Future.delayed(const Duration(milliseconds: 100), () {
                CustomSnackBar().showSnackBar(
                  context,
                  msg: "Product added to cart",
                  snackBarTypes: SnackBarTypes.success,
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

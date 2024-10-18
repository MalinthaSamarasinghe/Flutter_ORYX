import 'dart:io';
import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'widgets/offer_card.dart';
import '../cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../../core/other/theme_notifier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/presentation/error_box.dart';
import '../../core/presentation/search_field.dart';
import '../product_inner/product_inner_screen.dart';
import '../../core/presentation/screen_app_bar.dart';
import '../products/presentation/bloc/product_bloc.dart';
import '../products/presentation/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final void Function()? onLeadingPressCallback;

  const HomeScreen({super.key, this.onLeadingPressCallback});

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
          hasTitle: false,
          statusBarType: themeNotifier.isDarkMode ? StatusBarType.light : StatusBarType.dark,
          leadingType: LeadingType.none,
          trailingType: TrailingType.more,
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            /// Changes to apply based on orientation
            isPortrait = orientation == Orientation.portrait;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  /// Search Field
                  SearchField(
                    hint: "Search",
                    prefixIcon: "assets/svg/search.svg",
                    borderRadius: 20,
                    isEnabled: false,
                    textController: TextEditingController(),
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                  /// Offers
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Special Offers for You",
                              style: kInter600(context, color: themeNotifier.isDarkMode ? kColorWhite: kColorBlack, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                "See More",
                                style: kInter500(context, color: themeNotifier.isDarkMode ? kColorWhite: kColorBlack, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            OfferCard(
                              image: "assets/images/lap.png",
                              category: "Laptops",
                              numOfBrands: 6,
                              press: () {},
                              isDarkMode: themeNotifier.isDarkMode,
                            ),
                            OfferCard(
                              image: "assets/images/phone.png",
                              category: "Smartphones",
                              numOfBrands: 14,
                              press: () {},
                              isDarkMode: themeNotifier.isDarkMode,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  /// Banner
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kColorDarkBlue.withOpacity(0.8),
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "For New Users\n",
                            style: kInter600(context, color: kColorWhite, fontSize: 18),
                          ),
                          TextSpan(
                            text: "Get your 50% discount",
                            style: kInter600(context, color: kColorWhite, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// Popular Products
                  Column(
                    children: [
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Products",
                              style: kInter600(context, color: themeNotifier.isDarkMode ? kColorWhite: kColorBlack, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: (){
                                onLeadingPressCallback?.call();
                              },
                              child: Text(
                                "See All",
                                style: kInter500(context, color: themeNotifier.isDarkMode ? kColorWhite: kColorBlack, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        buildWhen: (prev, current) {
                          if (prev.status == ProductListStatus.initial && current.status == ProductListStatus.loading) {
                            return false;
                          } else {
                            return true;
                          }
                        },
                        builder: (context, state) {
                          return state.status == ProductListStatus.initial
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Platform.isAndroid
                                        ? const SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(color: kColorBlack, strokeWidth: 3),
                                          )
                                        : const CupertinoActivityIndicator(radius: 10),
                                  ),
                                )
                              : state.status == ProductListStatus.failure
                                  ? Padding(
                                      padding: EdgeInsets.only(top: isPortrait ? 120 : 0),
                                      child: ErrorBox(
                                        title: state.errorMessage ?? 'Something went wrong. Please try again later!',
                                        outerPadding: const EdgeInsets.symmetric(horizontal: 26),
                                      ),
                                    )
                                  : (state.productList ?? []).isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(top: isPortrait ? 120 : 0),
                                          child: ErrorBox(
                                            title: context.read<ProductBloc>().state.activeSearched == true
                                                ? "No products found for search keyword!"
                                                : state.errorMessage ?? "No products found!",
                                            outerPadding: const EdgeInsets.symmetric(horizontal: 26),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 220,
                                          child: MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            removeBottom: true,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (state.productList ?? []).length > 5 ? 5 : (state.productList ?? []).length,
                                              padding: const EdgeInsets.fromLTRB(20, 16, 6, 10),
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 120,
                                                  padding: const EdgeInsets.only(right: 15),
                                                  child: ProductCard(
                                                    imagePath: state.productList![index].image,
                                                    name: state.productList![index].name,
                                                    price: state.productList![index].price,
                                                    onPress: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return BlocProvider.value(
                                                              value: BlocProvider.of<CartBloc>(context),
                                                              child: ProductInnerScreen(
                                                                product: state.productList![index],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

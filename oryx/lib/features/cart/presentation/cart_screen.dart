import '../bloc/cart_bloc.dart';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/other/theme_notifier.dart';
import '../../../core/presentation/error_box.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/presentation/shimmer_builder.dart';
import '../../purchase_success/purchase_success_screen.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  final void Function()? onLeadingPressCallback;

  const CartScreen({super.key, this.onLeadingPressCallback});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  late final slidableController = SlidableController(this);
  bool isPortrait = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
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
          title: "Cart",
          statusBarType: themeNotifier.isDarkMode ? StatusBarType.light : StatusBarType.dark,
          leadingType: LeadingType.back,
          trailingType: TrailingType.none,
          onLeadingPress: () {
            FocusManager.instance.primaryFocus?.unfocus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            widget.onLeadingPressCallback?.call();
          },
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            /// Changes to apply based on orientation
            isPortrait = orientation == Orientation.portrait;
            return BlocBuilder<CartBloc, CartState>(
              buildWhen: (prev, current) {
                if (prev.cartStatus == CartListStatus.initial && current.cartStatus == CartListStatus.loading) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                if((state.cartList ?? []).isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: isPortrait ? 120 : 40),
                    child: const ErrorBox(
                      title: "No items in cart!",
                      outerPadding: EdgeInsets.symmetric(horizontal: 26),
                    ),
                  );
                }
                return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    itemCount: (state.cartList ?? []).length,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Slidable(
                          /// Specify a key if the Slidable is dismissible.
                          key: UniqueKey(),
                          /// The start action pane is the one at the left or the top side.
                          endActionPane: ActionPane(
                            /// A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            /// A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(
                              onDismissed: () {
                                context.read<CartBloc>().add(ProductRemoved(
                                  itemId: state.cartList![index].productId ?? -99999,
                                ));
                              },
                              dismissalDuration: const Duration(milliseconds: 0),
                              resizeDuration: const Duration(milliseconds: 0),
                              dismissThreshold: 0.85,
                            ),
                            /// All actions are defined in the children parameter.
                            children: [
                              /// A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<CartBloc>().add(ProductRemoved(
                                    itemId: state.cartList![index].productId ?? -99999,
                                  ));
                                  slidableController.close();
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                backgroundColor: kColorRed,
                                foregroundColor: kColorWhite,
                                icon: Icons.delete,
                                // Translate the message
                                label: 'Remove',
                              ),
                            ],
                          ),
                          /// The child of the Slidable is what the user sees when the
                          /// component is not dragged.
                          child: Container(
                            decoration: BoxDecoration(
                              color: kColorTextField,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                      aspectRatio: 0.88,
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: state.cartList![index].productImage ?? "",
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
                                      )
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.cartList![index].productName ?? "",
                                      style: kInter500(context, fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text.rich(
                                      TextSpan(
                                        text: "\$${state.cartList![index].productPrice}",
                                        style: kInter400(context, color: kColorRed, fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: " x${state.cartList![index].quantity}",
                                            style: kInter400(context, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: (context.watch<CartBloc>().state.cartList ?? []).isEmpty
            ? null
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -15),
                      color: kShadowColor.withOpacity(0.05),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Expanded(
                          //   child: Text.rich(
                          //     TextSpan(
                          //       text: "Total: ",
                          //       style: kInter500(context, color: themeNotifier.isDarkMode ? kColorWhite : kColorBlack, fontSize: 16),
                          //       children: [
                          //         TextSpan(
                          //           text: "337.15",
                          //           style: kInter500(context, color: kColorRed, fontSize: 14),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            child: MainButton(
                              height: 40,
                              title: "Checkout",
                              titleColor: themeNotifier.isDarkMode ? kColorBlack : kColorWhite,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                context.read<CartBloc>().add(const CartCleared());
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const PurchaseSuccessScreen();
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

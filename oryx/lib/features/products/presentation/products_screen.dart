import 'dart:io';
import 'bloc/product_bloc.dart';
import 'widgets/product_card.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../../core/other/wait_while.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/other/theme_notifier.dart';
import '../../../core/presentation/error_box.dart';
import '../../../core/presentation/search_field.dart';
import '../../product_inner/product_inner_screen.dart';
import '../../../core/presentation/screen_app_bar.dart';

class ProductsScreen extends StatefulWidget {
  final void Function()? onLeadingPressCallback;

  const ProductsScreen({super.key, this.onLeadingPressCallback});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isPortrait = true;

  @override
  void initState() {
    context.read<ProductBloc>().add(const InitialProductListEvent());
    super.initState();
  }

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
          title: "Products",
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
            return RefreshIndicator(
              onRefresh: () async {
                ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
                context.read<ProductBloc>().add(const InitialProductListEvent(isRefresh: true));
                await Future.delayed(const Duration(milliseconds: 100));
                await waitWhile(() {
                  return (productBloc.state.status == ProductListStatus.loading || productBloc.state.status == ProductListStatus.initial);
                }, const Duration(milliseconds: 100));
              },
              color: kColorBlack,
              strokeWidth: 2.5,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints){
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      SearchField(
                        hint: "Search",
                        prefixIcon: "assets/svg/search.svg",
                        textController: context.watch<ProductBloc>().searchController,
                        autofocus: context.read<ProductBloc>().state.activeSearched,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.search,
                        onSearched: (text) {
                          context.read<ProductBloc>().add(ProductSearchedRequested(keyWord: text));
                        },
                        onClear: () {
                          context.read<ProductBloc>().add(const ClearProductListRequested());
                        },
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 20),
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
                                      : Expanded(
                                          child: MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            removeBottom: true,
                                            child: GridView.builder(
                                              itemCount: (state.productList ?? []).length,
                                              padding: const EdgeInsets.fromLTRB(26, 0, 26, 10),
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 180,
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 6,
                                                crossAxisSpacing: 16,
                                              ),
                                              itemBuilder: (context, index) {
                                                return ProductCard(
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
                                                );
                                              },
                                            ),
                                          ),
                                        );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

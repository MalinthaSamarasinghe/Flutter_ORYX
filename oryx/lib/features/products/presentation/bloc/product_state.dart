part of 'product_bloc.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductListStatus status;
  final List<ProductEntity>? productList;
  final List<ProductEntity>? originalProductList;
  final bool? activeSearched;
  final String? errorMessage;

  const ProductState({
    required this.status,
    this.productList,
    this.originalProductList,
    this.activeSearched,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        status,
        productList,
        originalProductList,
        activeSearched,
        errorMessage,
      ];

  ProductState copyWith({
    ProductListStatus? status,
    List<ProductEntity>? productList,
    List<ProductEntity>? originalProductList,
    bool? activeSearched,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      productList: productList ?? this.productList,
      originalProductList: originalProductList ?? this.originalProductList,
      activeSearched: activeSearched ?? this.activeSearched,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

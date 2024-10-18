part of 'cart_bloc.dart';

enum CartListStatus { initial, loading, success, failure }

final class CartState extends Equatable {
  final CartListStatus cartStatus;
  final List<CartEntity>? cartList;
  final String? errorMessage;

  const CartState({
    this.cartStatus = CartListStatus.initial,
    this.cartList = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        cartStatus,
        cartList,
        errorMessage,
      ];

  CartState copyWith({
    CartListStatus? cartStatus,
    List<CartEntity>? cartList,
    String? errorMessage,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartList: cartList ?? this.cartList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final cartListStatusTypeValues = EnumValues({
  "initial": CartListStatus.initial,
  "loading": CartListStatus.loading,
  "success": CartListStatus.success,
  "failure": CartListStatus.failure,
});

class EnumValues<T> {
  late Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

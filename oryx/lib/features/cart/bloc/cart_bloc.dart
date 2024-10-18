import 'dart:async';
import '../Entitty/cart_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<ProductAdded>(_onProductAdded, transformer: Transformer.throttleDroppable());
    on<ProductRemoved>(_onProductRemoved, transformer: Transformer.throttleDroppable());
    on<CartCleared>(_onCartCleared, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onProductAdded(ProductAdded event, Emitter<CartState> emit) {
    List<CartEntity> tempProduct;

    /// Check if selectedProduct is null or empty
    if (state.cartList == null || state.cartList!.isEmpty) {
      /// Add the product with default values for other fields
      tempProduct = [event.item];
    } else {
      /// Copy the current list and add the new product
      tempProduct = List.from(state.cartList!);
      tempProduct.add(event.item);
    }
    emit(state.copyWith(cartList: tempProduct));
  }

  FutureOr<void> _onProductRemoved(ProductRemoved event, Emitter<CartState> emit) {
    List<CartEntity> tempProduct = List.from(state.cartList!);
    tempProduct.removeAt(event.itemId);
    emit(state.copyWith(cartList: tempProduct));
  }

  FutureOr<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) {
    emit(state.copyWith(cartList: []));
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartState(
      cartStatus: cartListStatusTypeValues.map[json['cartStatus']] ?? CartListStatus.initial,
      cartList: List<CartEntity>.from(json['cartList'].map((x) => CartEntity.fromJson(x))),
      errorMessage: json['errorMessage'],
    );
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    return {
      "cartStatus": cartListStatusTypeValues.reverse[state.cartStatus],
      "cartList" : List<dynamic>.from((state.cartList ?? []).map((e) => e.toJson())),
      "errorMessage" : state.errorMessage,
    };
  }
}

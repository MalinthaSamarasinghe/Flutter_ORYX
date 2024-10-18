part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

/// ProductAdded
class ProductAdded extends CartEvent {
  final CartEntity item;

  const ProductAdded({required this.item});

  @override
  List<Object> get props => [item];
}

/// ProductRemoved
class ProductRemoved extends CartEvent {
  final int itemId;

  const ProductRemoved({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

/// CartCleared
class CartCleared extends CartEvent {
  const CartCleared();

  @override
  List<Object> get props => [];
}

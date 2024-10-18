part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class InitialProductListEvent extends ProductEvent {
  final bool isRefresh;

  const InitialProductListEvent({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class ProductSearchedRequested extends ProductEvent {
  final String keyWord;

  const ProductSearchedRequested({required this.keyWord});

  @override
  List<Object> get props => [keyWord];
}

class ClearProductListRequested extends ProductEvent {
  const ClearProductListRequested();

  @override
  List<Object> get props => [];
}

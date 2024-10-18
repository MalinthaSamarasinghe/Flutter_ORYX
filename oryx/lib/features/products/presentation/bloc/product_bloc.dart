import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/entity/product_list_entity.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  /// TextEditingController
  final TextEditingController searchController = TextEditingController();

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  ProductBloc({required this.getProductsUseCase}) : super(const ProductState(status: ProductListStatus.initial)) {
    on<InitialProductListEvent>(_initialProductListEvent, transformer: Transformer.throttleDroppable());
    on<ProductSearchedRequested>(_productSearchedRequested, transformer: Transformer.throttleDebounce());
    on<ClearProductListRequested>(_clearProductListRequested, transformer: Transformer.throttleDroppable());
  }

  Future<void> _initialProductListEvent(InitialProductListEvent event, Emitter<ProductState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(status: ProductListStatus.loading));
    }

    Either<Failure, ProductListEntity> result = await getProductsUseCase(NoParams());
    result.fold(
      (failure) {
        String message = '';
        if (failure is ServerFailure) {
          message = failure.message;
        } else if (failure is NoConnectionFailure) {
          message = 'Please check your internet connection and try again!';
        } else {
          message = 'Something went wrong. Please try again later!';
        }
        emit(state.copyWith(
          status: ProductListStatus.failure,
          errorMessage: message,
        ));
      },
      (dataList) {
        emit(state.copyWith(
          status: ProductListStatus.success,
          productList: dataList.products,
          originalProductList: dataList.products,
        ));
      },
    );
  }

  Future<FutureOr<void>> _productSearchedRequested(ProductSearchedRequested event, Emitter<ProductState> emit) async {
    /// back to initial state if search text is empty
    if(event.keyWord == "" || event.keyWord.isEmpty) {
      searchController.clear();
      emit(state.copyWith(
        status: ProductListStatus.success,
        activeSearched: false,
        productList: state.originalProductList,
      ));
      return null;
    }

    emit(state.copyWith(status: ProductListStatus.loading, activeSearched: true));

    List<ProductEntity>? tempList = state.originalProductList?.toList();
    /// Filter list by key word (looking for matching in invoiceNo field)
    RegExp regExp = RegExp(event.keyWord, caseSensitive: false);
    tempList?.retainWhere((product) => product.name.contains(regExp));
    emit(state.copyWith(
      status: ProductListStatus.success,
      activeSearched: true,
      productList: tempList,
    ));
  }

  Future<FutureOr<void>> _clearProductListRequested(ClearProductListRequested event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductListStatus.loading, activeSearched: false));
    emit(state.copyWith(
      status: ProductListStatus.success,
      activeSearched: false,
      productList: state.originalProductList,
    ));
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductListEntityCWProxy {
  ProductListEntity message(String message);

  ProductListEntity products(List<ProductEntity> products);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductListEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductListEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductListEntity call({
    String? message,
    List<ProductEntity>? products,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductListEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductListEntity.copyWith.fieldName(...)`
class _$ProductListEntityCWProxyImpl implements _$ProductListEntityCWProxy {
  const _$ProductListEntityCWProxyImpl(this._value);

  final ProductListEntity _value;

  @override
  ProductListEntity message(String message) => this(message: message);

  @override
  ProductListEntity products(List<ProductEntity> products) =>
      this(products: products);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductListEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductListEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductListEntity call({
    Object? message = const $CopyWithPlaceholder(),
    Object? products = const $CopyWithPlaceholder(),
  }) {
    return ProductListEntity(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      products: products == const $CopyWithPlaceholder() || products == null
          ? _value.products
          // ignore: cast_nullable_to_non_nullable
          : products as List<ProductEntity>,
    );
  }
}

extension $ProductListEntityCopyWith on ProductListEntity {
  /// Returns a callable class that can be used as follows: `instanceOfProductListEntity.copyWith(...)` or like so:`instanceOfProductListEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductListEntityCWProxy get copyWith =>
      _$ProductListEntityCWProxyImpl(this);
}

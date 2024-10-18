// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductEntityCWProxy {
  ProductEntity id(int id);

  ProductEntity name(String name);

  ProductEntity description(String description);

  ProductEntity price(String price);

  ProductEntity stock(int stock);

  ProductEntity image(String image);

  ProductEntity createdAt(DateTime createdAt);

  ProductEntity updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductEntity call({
    int? id,
    String? name,
    String? description,
    String? price,
    int? stock,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductEntity.copyWith.fieldName(...)`
class _$ProductEntityCWProxyImpl implements _$ProductEntityCWProxy {
  const _$ProductEntityCWProxyImpl(this._value);

  final ProductEntity _value;

  @override
  ProductEntity id(int id) => this(id: id);

  @override
  ProductEntity name(String name) => this(name: name);

  @override
  ProductEntity description(String description) =>
      this(description: description);

  @override
  ProductEntity price(String price) => this(price: price);

  @override
  ProductEntity stock(int stock) => this(stock: stock);

  @override
  ProductEntity image(String image) => this(image: image);

  @override
  ProductEntity createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  ProductEntity updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? stock = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ProductEntity(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      price: price == const $CopyWithPlaceholder() || price == null
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as String,
      stock: stock == const $CopyWithPlaceholder() || stock == null
          ? _value.stock
          // ignore: cast_nullable_to_non_nullable
          : stock as int,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ProductEntityCopyWith on ProductEntity {
  /// Returns a callable class that can be used as follows: `instanceOfProductEntity.copyWith(...)` or like so:`instanceOfProductEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductEntityCWProxy get copyWith => _$ProductEntityCWProxyImpl(this);
}

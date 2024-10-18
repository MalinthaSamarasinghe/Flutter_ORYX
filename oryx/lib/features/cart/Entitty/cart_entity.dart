import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_entity.g.dart';
part 'cart_entity.freezed.dart';

@freezed
class CartEntity with _$CartEntity {
  const factory CartEntity({
    required int? productId,
    required String? productName,
    required double? productPrice,
    required String? productImage,
    required int? quantity,
  }) = _CartEntity;

  factory CartEntity.fromJson(Map<String, Object?> json) => _$CartEntityFromJson(json);
}

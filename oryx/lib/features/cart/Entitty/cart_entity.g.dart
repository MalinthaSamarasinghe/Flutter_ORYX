// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartEntityImpl _$$CartEntityImplFromJson(Map<String, dynamic> json) =>
    _$CartEntityImpl(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      productImage: json['productImage'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CartEntityImplToJson(_$CartEntityImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'productImage': instance.productImage,
      'quantity': instance.quantity,
    };

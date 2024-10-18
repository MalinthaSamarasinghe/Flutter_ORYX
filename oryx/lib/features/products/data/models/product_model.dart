// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/entity/product_list_entity.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel extends Equatable {
  final String? message;
  final List<Product>? products;

  const ProductModel({
    this.message,
    this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [message, products];

  ProductListEntity toEntity() {
    return ProductListEntity(
      message: message ?? "",
      products: List<ProductEntity>.from(
        (products ?? []).map(
          (products) {
            return ProductEntity(
              id: products.id ?? -99999,
              name: products.name ?? "",
              description: products.description ?? "",
              price: products.price ?? "",
              stock: products.stock ?? 0,
              image: products.image ?? "",
              createdAt: products.createdAt ?? DateTime(2024),
              updatedAt: products.updatedAt ?? DateTime(2024),
            );
          },
        ),
      ),
    );
  }
}

class Product extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final int? stock;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        stock,
        image,
        createdAt,
        updatedAt,
      ];
}

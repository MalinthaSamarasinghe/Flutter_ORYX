import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'product_entity.g.dart';

@CopyWith()
class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final int stock;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

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

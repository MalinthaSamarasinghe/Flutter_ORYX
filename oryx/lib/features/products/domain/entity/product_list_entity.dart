import 'product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'product_list_entity.g.dart';

@CopyWith()
class ProductListEntity extends Equatable {
  final String message;
  final List<ProductEntity> products;

  const ProductListEntity({
    required this.message,
    required this.products,
  });

  @override
  List<Object?> get props => [
        message,
        products,
      ];
}

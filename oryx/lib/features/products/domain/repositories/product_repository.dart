import 'package:dartz/dartz.dart';
import '../entity/product_list_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListEntity>> getProductList();
}

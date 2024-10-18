import 'package:dartz/dartz.dart';
import '../entity/product_list_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements UseCase<ProductListEntity, NoParams> {
  final ProductRepository productRepository;

  GetProductsUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<Failure, ProductListEntity>> call(NoParams param) async {
    return await productRepository.getProductList();
  }
}

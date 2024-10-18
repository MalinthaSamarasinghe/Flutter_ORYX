import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/product_list_entity.dart';
import '../datasource/product_local_data_source.dart';
import '../datasource/product_remote_data_source.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductListEntity>> getProductList() async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final productListData = await remoteDataSource.getProductList();
        localDataSource.cacheProductList(productListData);
        return Right(productListData.toEntity());
      } on ServerException catch (serverException) {
        return Left(ServerFailure(message: serverException.errorMessage));
      }
    } else {
      try {
        final productListData = await localDataSource.getCachedProductList();
        return Right(productListData.toEntity());
      } on CacheException {
        return Left(NoConnectionFailure());
      }
    }
  }
}

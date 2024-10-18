import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../core/errors/exception.dart';
import '../../../../../core/network/dio_client.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductList();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  const ProductRemoteDataSourceImpl({
    required this.dioClient,
  });

  @override
  Future<ProductModel> getProductList() async {
    try {
      Response response = await dioClient.public.get(ApiEndpoints.products);
      return productModelFromJson(response.data);
    } on DioException catch (err) {
      throw ServerException.fromDioError(err);
    } catch (e) {
      throw ServerException(errorMessage: '$e', unexpectedError: true);
    }
  }
}

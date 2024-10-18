import '../models/product_model.dart';
import '../../../../core/errors/exception.dart';
import '../../../../utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getCachedProductList();

  Future<void> cacheProductList(ProductModel productModel);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  const ProductLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheProductList(ProductModel productModel) async {
    sharedPreferences.setString(CachedModelKeys.productList, productModelToJson(productModel));
  }

  @override
  Future<ProductModel> getCachedProductList() async {
    final jsonString = sharedPreferences.getString(CachedModelKeys.productList);
    if (jsonString != null) {
      return Future.value(productModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}

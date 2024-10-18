import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'core/repositories/auth_repository.dart';
import 'core/blocs/authentication/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/interceptors/authorization_interceptor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/login/domain/usecase/login_usecase.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/domain/repository/login_repository.dart';
import 'features/login/data/repository/login_repository_impl.dart';
import 'features/login/data/datasource/login_remote_data_source.dart';

import 'features/register/domain/usecase/register_usecase.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'features/register/domain/repository/register_repository.dart';
import 'features/register/data/repository/register_repository_impl.dart';
import 'features/register/data/datasource/register_remote_data_source.dart';

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/domain/usecases/get_products_usecase.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/data/datasource/product_local_data_source.dart';
import 'features/products/data/datasource/product_remote_data_source.dart';

import 'features/profile/domain/usecase/get_current_location.dart';
import 'features/profile/data/datasource/current_location_data_source.dart';
import 'features/profile/domain/repository/current_location_repository.dart';
import 'features/profile/data/repository/current_location_repository_impl.dart';
import 'features/profile/presentation/bloc/current_location/current_location_bloc.dart';

import 'features/cart/bloc/cart_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocators() async {
  /// Feature: authentication
  // Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  /// Feature: Login
  // Blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(loginRepository: sl()));
  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(dioClient: sl()));

  /// Feature: Register
  // Blocs
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(registerUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(registerRepository: sl()));
  // Repositories
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(() => RegisterRemoteDataSourceImpl(dioClient: sl()));

  /// Feature: Product List
  // Blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(getProductsUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(productRepository: sl()));
  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(dioClient: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  /// Feature: Current Location
  // Blocs
  sl.registerFactory<CurrentLocationBloc>(() => CurrentLocationBloc(getCurrentLocation: sl()));
  // Use Cases
  sl.registerLazySingleton<GetCurrentLocation>(() => GetCurrentLocation(currentLocationRepository: sl()));
  // Repositories
  sl.registerLazySingleton<CurrentLocationRepository>(() => CurrentLocationRepositoryImpl(dataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<CurrentLocationDataSource>(() => const CurrentLocationDataSourceImpl());

  /// Feature: Cart
  // Blocs
  sl.registerFactory<CartBloc>(() => CartBloc());

  /// Network
  sl.registerFactory<Dio>(() => Dio());
  sl.registerFactory<DioClient>(() => DioClient(public: sl<Dio>(), auth: sl<Dio>()..interceptors.add(sl<AuthorizationInterceptor>())));
  sl.registerFactory<AuthorizationInterceptor>(() => AuthorizationInterceptor(authBloc: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  /// Plugins
  /// Shared Preferences
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
}

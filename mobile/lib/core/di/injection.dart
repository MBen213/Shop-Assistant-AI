import 'package:get_it/get_it.dart';

import '../database/database_helper.dart';

// ====================================================
// Products
// ====================================================

import '../../features/products/data/datasource/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';

import '../../features/products/domain/repositories/product_repository.dart';

import '../../features/products/domain/usecases/add_product_usecase.dart';
import '../../features/products/domain/usecases/delete_product_usecase.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/domain/usecases/update_product_usecase.dart';

import '../../features/products/presentation/providers/products_provider.dart';

// ====================================================
// Users
// ====================================================

import '../../features/users/data/datasource/user_local_datasource.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';

import '../../features/users/domain/repositories/user_repository.dart';

import '../../features/users/domain/usecases/add_user_usecase.dart';
import '../../features/users/domain/usecases/change_password_usecase.dart';
import '../../features/users/domain/usecases/delete_user_usecase.dart';
import '../../features/users/domain/usecases/get_current_user_usecase.dart';
import '../../features/users/domain/usecases/get_users_usecase.dart';
import '../../features/users/domain/usecases/login_usecase.dart';
import '../../features/users/domain/usecases/logout_usecase.dart';
import '../../features/users/domain/usecases/update_user_usecase.dart';

import '../../features/users/presentation/providers/auth_provider.dart';
import '../../features/users/presentation/providers/users_provider.dart';

// ====================================================
// Dashboard
// ====================================================

import '../../features/dashboard/data/datasource/dashboard_local_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';

import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';

import '../../features/dashboard/presentation/providers/dashboard_provider.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ====================================================
  // Database
  // ====================================================

  sl.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // ====================================================
  // Users
  // ====================================================

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl<UserLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<AddUserUseCase>(
    () => AddUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<DeleteUserUseCase>(
    () => DeleteUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  sl.registerFactory<UsersProvider>(
    () => UsersProvider(
      getUsersUseCase: sl<GetUsersUseCase>(),
      addUserUseCase: sl<AddUserUseCase>(),
      updateUserUseCase: sl<UpdateUserUseCase>(),
      deleteUserUseCase: sl<DeleteUserUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
    ),
  );

  // ====================================================
  // Dashboard
  // ====================================================

  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(
      sl<DatabaseHelper>(),
    ),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      sl<DashboardLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetDashboardStatsUseCase>(
    () => GetDashboardStatsUseCase(
      sl<DashboardRepository>(),
    ),
  );

  sl.registerFactory<DashboardProvider>(
    () => DashboardProvider(
      getDashboardStatsUseCase: sl<GetDashboardStatsUseCase>(),
    )..loadDashboard(),
  );

  // ====================================================
  // Products
  // ====================================================

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      sl<ProductRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(
      sl<ProductRepository>(),
    ),
  );

  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(
      sl<ProductRepository>(),
    ),
  );

  sl.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(
      sl<ProductRepository>(),
    ),
  );

  sl.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(
      sl<ProductRepository>(),
    ),
  );

  sl.registerFactory<ProductsProvider>(
    () => ProductsProvider(
      getProductsUseCase: sl<GetProductsUseCase>(),
      addProductUseCase: sl<AddProductUseCase>(),
      updateProductUseCase: sl<UpdateProductUseCase>(),
      deleteProductUseCase: sl<DeleteProductUseCase>(),
    ),
  );
}
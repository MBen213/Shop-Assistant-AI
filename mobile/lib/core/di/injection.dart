import 'package:get_it/get_it.dart';

// ====================================================
// Core
// ====================================================

import '../database/database_helper.dart';
import '../database/dao/products_dao.dart';

// ====================================================
// Products
// ====================================================

import '../../features/products/data/datasource/product_local_datasource.dart';
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

// ====================================================
// App Settings
// ====================================================

import '../../features/app_settings/data/datasource/app_settings_local_datasource.dart';
import '../../features/app_settings/data/repositories/app_settings_repository_impl.dart';

import '../../features/app_settings/domain/repositories/app_settings_repository.dart';

import '../../features/app_settings/domain/usecases/get_app_settings_usecase.dart';
import '../../features/app_settings/domain/usecases/save_app_settings_usecase.dart';

import '../../features/app_settings/presentation/providers/app_settings_provider.dart';

// ====================================================
// GetIt
// ====================================================

final sl = GetIt.instance;

// ====================================================
// Initialize Dependencies
// ====================================================

Future<void> initDependencies() async {
  // ==================================================
  // DATABASE
  // ==================================================

  sl.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // ==================================================
  // USERS
  // ==================================================

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl<UserLocalDataSource>(),
    ),
  );

  // ------------------------------
  // User UseCases
  // ------------------------------

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

  // ------------------------------
  // Auth Provider
  // ------------------------------

  sl.registerFactory<AuthProvider>(
    () => AuthProvider(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  // ------------------------------
  // Users Provider
  // ------------------------------

  sl.registerFactory<UsersProvider>(
    () => UsersProvider(
      getUsersUseCase: sl<GetUsersUseCase>(),
      addUserUseCase: sl<AddUserUseCase>(),
      updateUserUseCase: sl<UpdateUserUseCase>(),
      deleteUserUseCase: sl<DeleteUserUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
    ),
  );

  // ==================================================
  // DASHBOARD
  // ==================================================

  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSource(),
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

  // ==================================================
  // PRODUCTS
  // ==================================================

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(
      ProductsDao.instance,
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      sl<ProductLocalDataSource>(),
    ),
  );

  // ------------------------------
  // Product UseCases
  // ------------------------------

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

  // ------------------------------
  // Products Provider
  // ------------------------------

  sl.registerFactory<ProductsProvider>(
    () => ProductsProvider(
      getProductsUseCase: sl<GetProductsUseCase>(),
      addProductUseCase: sl<AddProductUseCase>(),
      updateProductUseCase: sl<UpdateProductUseCase>(),
      deleteProductUseCase: sl<DeleteProductUseCase>(),
    ),
  );

  // ==================================================
  // APP SETTINGS
  // ==================================================

  sl.registerLazySingleton<AppSettingsLocalDataSource>(
    () => AppSettingsLocalDataSource(),
  );

  sl.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(
      sl<AppSettingsLocalDataSource>(),
    ),
  );

  // ------------------------------
  // App Settings UseCases
  // ------------------------------

  sl.registerLazySingleton<GetAppSettingsUseCase>(
    () => GetAppSettingsUseCase(
      sl<AppSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton<SaveAppSettingsUseCase>(
    () => SaveAppSettingsUseCase(
      sl<AppSettingsRepository>(),
    ),
  );

  // ------------------------------
  // App Settings Provider
  // ------------------------------

  sl.registerFactory<AppSettingsProvider>(
    () => AppSettingsProvider(
      getSettingsUseCase: sl<GetAppSettingsUseCase>(),
      saveSettingsUseCase: sl<SaveAppSettingsUseCase>(),
    ),
  );
}
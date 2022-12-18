import 'package:advanced_app/app/app_prefs.dart';
import 'package:advanced_app/data/data_source/local_data_source.dart';
import 'package:advanced_app/data/data_source/remote_data_source.dart';
import 'package:advanced_app/data/network/app_api.dart';
import 'package:advanced_app/data/network/dio_factory.dart';
import 'package:advanced_app/data/network/network_info.dart';
import 'package:advanced_app/data/repository/repository_impl.dart';
import 'package:advanced_app/domain/repository/repository.dart';
import 'package:advanced_app/domain/usecase/forget_password_usecase.dart';
import 'package:advanced_app/domain/usecase/home_usecase.dart';
import 'package:advanced_app/domain/usecase/login_usecase.dart';
import 'package:advanced_app/domain/usecase/register_usecase.dart';
import 'package:advanced_app/domain/usecase/store_details_usecase.dart';
import 'package:advanced_app/presentation/forgot_password/view_model/forget_password_view_model.dart';
import 'package:advanced_app/presentation/login/view_model/login_view_model.dart';
import 'package:advanced_app/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:advanced_app/presentation/register/view_model/register_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/store_details/view_model/store_details_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  //shared prefs instance
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreference>(
      // هتجيب الانستانس اللي انا عايزه get_it و  instance() او ممكن اكتب   '<Shared Prefrences>'  هنا ممكن احط
      () => AppPreference(instance<SharedPreferences>()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory instance

  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(AppPreference(instance())));

  // app service client instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  //local data source instance
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUsecase>()) {
    instance.registerFactory<StoreDetailsUsecase>(
        () => StoreDetailsUsecase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}

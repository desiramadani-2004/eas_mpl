import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/domain/repositories/news_repository.dart';
import '../../features/home/domain/usecases/get_news_articles_usecase.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';


final locator = GetIt.instance; // [cite: 85]

void setupLocator() { // [cite: 86]
  // 1. Register Dio (Network) [cite: 88]
  locator.registerLazySingleton<Dio>(() { // [cite: 89]
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl)); // [cite: 90]
    
    // Kita tambahkan logger interseptor standar [cite: 91]
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true)); // [cite: 92]
    return dio;
  });

  // 2. Register Repository (Data Layer)
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(locator()), // locator() akan otomatis mencari Dio di atas
  );

  // 3. Register UseCase (Domain Layer)
  locator.registerLazySingleton(
    () => GetNewsArticlesUseCase(locator()),
  );

  // 4. Register Cubit (Presentation Layer - Pakai Factory biar fresh)
  locator.registerFactory(
    () => NewsCubit(locator()),
  );
}
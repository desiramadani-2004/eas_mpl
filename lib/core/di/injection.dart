import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../config/env_config.dart';
import '../../features/home/data/models/news_model.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/domain/repositories/news_repository.dart';
import '../../features/home/domain/usecases/get_news_articles_usecase.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';


final locator = GetIt.instance; // [cite: 85]

// 1. Diubah menjadi Future<void> async karena Isar butuh proses loading
Future<void> setupLocator() async { 
  
  // 2. Buka & Register Database Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [NewsModelSchema], // Ini memanggil skema yang di-generate oleh file .g.dart 
    directory: dir.path,
  );
  locator.registerLazySingleton<Isar>(() => isar);

  // 3. Register Dio (Network)
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // 4. Register Repository (Data Layer)
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(locator(), locator()), 
  );

  // 5. Register UseCase (Domain Layer)
  locator.registerLazySingleton(
    () => GetNewsArticlesUseCase(locator()),
  );

  // 6. Register Cubit (Presentation Layer)
  locator.registerFactory(
    () => NewsCubit(locator()),
  );
}
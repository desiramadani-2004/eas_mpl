import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';

final locator = GetIt.instance; // [cite: 85]

void setupLocator() { // [cite: 86]
  // 1. Register Dio (Network) [cite: 88]
  locator.registerLazySingleton<Dio>(() { // [cite: 89]
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl)); // [cite: 90]
    
    // Kita tambahkan logger interseptor standar [cite: 91]
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true)); // [cite: 92]
    return dio;
  });

  // Nanti Anda tambahkan pendaftaran Repository dan Cubit di sini! [cite: 94]
}
class EnvConfig {
  EnvConfig._();

  // Kita pakai kata kunci 'FLAVOR' untuk menentukan mode aplikasi
  static const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'DEV');
  
  // Base URL disiapkan sekalian untuk API Berita nanti (DigiNews)
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://newsapi.org/v2/');

  // Helper untuk ngecek apakah aplikasi di mode Production
  static bool get isProduction => flavor == 'PROD';

  // TANTANGAN ANTI-AI: Nama app berubah dinamis
  static String get appName {
    if (isProduction) {
      return 'UTD - 20123042'; // Versi PROD wajib pakai NIM
    }
    return 'DEV - Desi'; // Versi DEV wajib pakai Nama Depan
  }
}
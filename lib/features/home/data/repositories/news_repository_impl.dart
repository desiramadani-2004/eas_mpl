import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;
  final Isar isar;

  NewsRepositoryImpl(this.dio, this.isar);

  @override
  Future<List<NewsArticle>> fetchNews() async {
    try {
      final String myApiKey = '653d53f6c5ce4503a570544dc89f2805';
      final response = await dio.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=$myApiKey');
      
      if (response.statusCode == 200) {
        final List articlesJson = response.data['articles'] ?? [];
        
        // Mengonversi kiriman list JSON menjadi bentuk list NewsModel
        List<NewsModel> models = articlesJson.map((json) => NewsModel.fromJson(json)).toList();

        // Mengurutkan data judul berita dari A ke Z (Ascending). 
        models.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

        // LOGIKA CACHING: Simpan data yang berhasil ditarik ke Isar Database secara lokal
        await isar.writeTxn(() async {
          await isar.newsModels.clear(); // newsModels adalah nama collection di model Isar kamu
          await isar.newsModels.putAll(models); // Simpan semua model baru
        });

        // Kembalikan data yang sudah rapi terurut ke dalam bentuk Entity
        return models.map((model) => model.toEntity()).toList();
      }
      
      return [];
    } catch (e) {
      print('🔴 ERROR/INTERNET MATI: $e');
      
      try {
        // LOGIKA OFFLINE: Jika internet mati (Dio throw error), ambil data terakhir dari Isar
        print('🟢 MENGAMBIL DATA DARI CACHE ISAR...');
        final List<NewsModel> cachedModels = await isar.newsModels.where().findAll();
        
        if (cachedModels.isNotEmpty) {
          // Tetap pastikan data dari cache terurut A-Z sesuai request rubrik UAS
          cachedModels.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
          return cachedModels.map((model) => model.toEntity()).toList();
        }
      } catch (isarError) {
        print('🔴 GAGAL MENGAMBIL DATA ISAR: $isarError');
      }

      // Jika cache Isar juga kosong atau bermasalah, baru lempar exception ke Cubit
      throw Exception('Gagal memuat berita, periksa koneksi Anda.');
    }
  }
}
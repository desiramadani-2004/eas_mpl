import 'package:dio/dio.dart';
import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;

  NewsRepositoryImpl(this.dio);

  @override
  Future<List<NewsArticle>> fetchNews() async {
    try {
      // url tiruan dulu untuk ngetes struktur datanya
      final response = await dio.get('https://newsapi.org/v2/top-headlines?country=id&apiKey=MOCK_KEY');
      
      if (response.statusCode == 200) {
        final List articlesJson = response.data['articles'] ?? [];
        
        // Mengonversi kiriman list JSON menjadi bentuk list NewsModel
        List<NewsModel> models = articlesJson.map((json) => NewsModel.fromJson(json)).toList();

        // Mengurutkan data judul berita dari A ke Z (Ascending). 
        models.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

        // Kembalikan data yang sudah rapi terurut ke dalam bentuk Entity
        return models.map((model) => model.toEntity()).toList();
      }
      
      return [];
    } catch (e) {
      // Jika internet mati, nanti bisa panggil Isar Database offline-nya
      throw Exception('Gagal memuat berita, periksa koneksi Anda.');
    }
  }
}
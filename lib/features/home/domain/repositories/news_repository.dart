import '../entities/news_article.dart';

abstract class NewsRepository {
  // Fungsi abstrak untuk mengambil daftar berita
  Future<List<NewsArticle>> fetchNews();
}
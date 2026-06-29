import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class GetNewsArticlesUseCase {
  final NewsRepository repository;

  GetNewsArticlesUseCase(this.repository);

  // Fungsi call() biar usecase bisa dieksekusi langsung
  Future<List<NewsArticle>> call() async {
    return await repository.fetchNews();
  }
}
import 'package:isar/isar.dart';
import '../../domain/entities/news_article.dart';

// untuk Isar biar nanti bisa otomatis generate file pendukung
part 'news_model.g.dart';

@collection
class NewsModel {
  Id id = Isar.autoIncrement; // Id otomatis buatan Isar
  
  late String title;
  late String description;
  late String urlToImage;
  late String content;

  // Constructor kosong yang diwajibkan oleh Isar Database
  NewsModel();

  // Fungsi untuk mengubah format JSON dari API menjadi objek Model 
  NewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? 'Tanpa Judul';
    description = json['description'] ?? 'Tidak ada deskripsi untuk berita ini.';
    urlToImage = json['urlToImage'] ?? '';
    content = json['content'] ?? '';
  }

  // Fungsi penting untuk mengubah Model (Data Layer) menjadi Entity (Domain Layer)
  NewsArticle toEntity() {
    return NewsArticle(
      title: title,
      description: description,
      urlToImage: urlToImage,
      content: content,
    );
  }
}
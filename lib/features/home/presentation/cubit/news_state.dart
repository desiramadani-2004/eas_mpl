import 'package:equatable/equatable.dart';
import '../../domain/entities/news_article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

// 1. Kondisi awal / saat sedang memuat data
class NewsLoading extends NewsState {}

// 2. Kondisi sukses saat data berhasil didapat
class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  const NewsLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

// 3. Kondisi gagal (misal tidak ada internet dan cache kosong)
class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}
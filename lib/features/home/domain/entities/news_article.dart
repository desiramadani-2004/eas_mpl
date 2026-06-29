import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
  });

  // Equatable untuk Unit Test 
  @override
  List<Object?> get props => [title, description, urlToImage, content];
}
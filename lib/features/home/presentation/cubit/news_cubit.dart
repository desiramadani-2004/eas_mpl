import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_news_articles_usecase.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsArticlesUseCase getNewsArticlesUseCase;

  // Saat pertama kali dipanggil, layar otomatis masuk mode Loading
  NewsCubit(this.getNewsArticlesUseCase) : super(NewsLoading());

  // Fungsi untuk mengambil berita dan mengubah state layar
  Future<void> fetchNews() async {
    emit(NewsLoading()); // Pastikan layar loading muncul
    try {
      // Menjalankan usecase untuk mengambil data
      final articles = await getNewsArticlesUseCase();
      
      if (articles.isEmpty) {
        emit(const NewsError('Tidak ada berita saat ini.'));
      } else {
        emit(NewsLoaded(articles)); // Layar berubah jadi sukses menampilkan data
      }
    } catch (e) {
      emit(NewsError(e.toString())); // Layar berubah jadi error
    }
  }
}
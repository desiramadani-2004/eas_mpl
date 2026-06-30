import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/di/injection.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider untuk menyuntikkan Cubit ke halaman ini
    // ..fetchNews() begitu halaman dibuka, langsung jalankan fungsi ambil berita
    return BlocProvider(
      create: (context) => locator<NewsCubit>()..fetchNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(EnvConfig.appName),
          backgroundColor: EnvConfig.isProduction ? const Color(0xFF0D47A1) : Colors.teal,
          foregroundColor: Colors.white,

          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                context.push('/profile'); // Pindah ke halaman ProfilePage
              },
            ),
          ],
        ),
        
        // BlocBuilder membangun ulang layar sesuai dengan kondisi State (Cubit)
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            
            // 1. KONDISI LOADING
            if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } 
            
            // 2. KONDISI SUKSES
            else if (state is NewsLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(
                        article.title, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        article.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.article, color: Colors.blueAccent, size: 40),
                    ),
                  );
                },
              );
            } 
            
            // 3. KONDISI ERROR
            else if (state is NewsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message, 
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Kondisi default kosong (berjaga-jaga)
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
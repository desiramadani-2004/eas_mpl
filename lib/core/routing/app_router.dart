import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'package:uas_mobile_lanjut/features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Halaman home
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      // Profile
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
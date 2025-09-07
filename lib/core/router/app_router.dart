import 'package:go_router/go_router.dart';
import 'package:the_movie_buff/src/movies/views/home_page.dart';

class AppRouter {
  static GoRouter generateRoutes() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
      ],
    );
  }
}

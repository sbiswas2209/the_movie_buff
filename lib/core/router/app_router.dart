import 'package:go_router/go_router.dart';
import 'package:the_movie_buff/src/movies/views/details_page.dart';
import 'package:the_movie_buff/src/movies/views/home_page.dart';

class AppRouter {
  static GoRouter generateRoutes() {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/details/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters["id"]!);
            return DetailsPage(id: id);
          },
        ),
      ],
    );
  }
}

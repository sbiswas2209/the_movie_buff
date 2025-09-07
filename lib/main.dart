import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie_buff/core/router/app_router.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/services/database_service.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigService.instance.loadConfig();
  await DatabaseService.instance.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoviesCubit(MoviesRepositoryImpl())),
      ],
      child: const TheMovieBuffApp(),
    ),
  );
}

class TheMovieBuffApp extends StatelessWidget {
  const TheMovieBuffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'The Movie Buff',
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: const Color(0XFF0B0D0E),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0XFF0B0D0E),
              centerTitle: false,
              elevation: 0,
              foregroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Ubuntu',
              ),
            ),
            fontFamily: 'Ubuntu',
          ),
          routerConfig: AppRouter.generateRoutes(),
        );
      },
    );
  }
}

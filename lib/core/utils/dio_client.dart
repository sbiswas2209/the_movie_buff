import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/utils/custom_logger.dart';

final logger = Logger();

Dio get dioClient {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: ConfigService.instance.apiBaseUrl,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'accept': 'application/json',
        'Authorization': 'Bearer ${ConfigService.instance.apiReadAccessToken}',
      },
    ),
  );

  dio.interceptors.add(CustomLogger());

  return dio;
}

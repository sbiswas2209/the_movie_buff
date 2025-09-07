import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

class CustomLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i("➡️ REQUEST[${options.method}] => PATH: ${options.uri}");
    _logger.d("Headers: ${options.headers}");
    if (options.data != null) {
      _logger.d("Body: ${options.data}");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      "✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}",
    );
    _logger.d("Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      "❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}",
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      _logger.w("Error Data: ${err.response?.data}");
    }
    super.onError(err, handler);
  }
}

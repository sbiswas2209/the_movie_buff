import 'package:the_movie_buff/network/exceptions/custom_exception.dart';

class ConfigurationNotLoadedException extends CustomException {
  ConfigurationNotLoadedException() : super("Image base URL not loaded");
}

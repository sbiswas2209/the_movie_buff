import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movie_buff/core/utils/dio_client.dart';
import 'package:the_movie_buff/data/remote/genre_item.dart';
import 'package:the_movie_buff/network/api/config/config_client.dart';
import 'package:the_movie_buff/network/exceptions/configuration_not_loaded_exception.dart';

class ConfigService {
  static final ConfigService _instance = ConfigService._internal();

  static ConfigService get instance => _instance;

  factory ConfigService() {
    return _instance;
  }

  ConfigService._internal();

  late final String _apiKey;
  late final String _apiReadAccessToken;
  late final String _apiBaseUrl;
  late final String? _imageBaseUrl;
  late final List<String>? _availablePosterSizes;
  late final List<GenreItem>? _genres;

  String get apiKey => _apiKey;

  String get apiReadAccessToken => _apiReadAccessToken;

  String get apiBaseUrl => _apiBaseUrl;

  List<String> get availablePosterSizes {
    if (_availablePosterSizes == null) {
      throw ConfigurationNotLoadedException();
    }
    return _availablePosterSizes;
  }

  String get imageBaseUrl {
    if (_imageBaseUrl == null) {
      throw ConfigurationNotLoadedException();
    }
    return _imageBaseUrl;
  }

  List<GenreItem> get genres {
    if (_genres == null) {
      throw ConfigurationNotLoadedException();
    }
    return _genres;
  }

  Future<void> loadConfig() async {
    await dotenv.load(fileName: ".env");

    _apiKey = dotenv.env["API_KEY"]!;
    _apiReadAccessToken = dotenv.env["API_READ_ACCESS_TOKEN"]!;
    _apiBaseUrl = dotenv.env["API_BASE_URL"] ?? "https://api.themoviedb.org/3";

    final configurationClient = ConfigClient(dioClient);

    final configuration = await configurationClient.getConfiguration();
    _imageBaseUrl = configuration.images.baseUrl;
    _availablePosterSizes = configuration.images.posterSizes;

    final genreResponse = await configurationClient.getGenreList();

    _genres = genreResponse.genres;
  }
}

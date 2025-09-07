import 'package:the_movie_buff/core/services/config_service.dart';

String findNearestPosterSize(double desiredSize) {
  return _findNearestSize(
    desiredSize,
    ConfigService.instance.availablePosterSizes,
  );
}

String _findNearestSize(double desiredSize, List<String> availableSizes) {
  List<double> sizes = availableSizes
      .where((e) => e != "original")
      .map<double>((e) => double.parse(e.substring(1)))
      .toList();
  double nearestSize = sizes.first;
  double smallestDifference = (desiredSize - nearestSize).abs();

  for (double size in sizes) {
    double difference = (desiredSize - size).abs();
    if (difference < smallestDifference) {
      smallestDifference = difference;
      nearestSize = size;
    }
  }

  return 'w${nearestSize.toInt()}';
}

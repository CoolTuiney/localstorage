import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polyLinesPoints;
  final String totalDistance;
  final String totalDuration;

  const Directions(
      {required this.bounds,
      required this.polyLinesPoints,
      required this.totalDistance,
      required this.totalDuration});

  factory Directions.fromMap(Map<String, dynamic> map) {
    //  if((map['routes']as List).isEmpty) {
    //    return null;
    //  }
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final norteast = data['bounds']['norteast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        northeast: LatLng(norteast['lat'], norteast['lng']),
        southwest: LatLng(southwest['lat'], southwest['lng']));

    String distance = '';
    String duration = '';

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return Directions(
      bounds: bounds,
      polyLinesPoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
          totalDistance: distance,
          totalDuration: duration,
    );
  }
}

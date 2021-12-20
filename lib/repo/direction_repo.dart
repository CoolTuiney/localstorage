import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localstorage/model/directions.dart';

class DirectionRepository {
  final String _googleAPIKey = 'AIzaSyCNuamnGTIbQ8NqZEWFn6qRyJqtaEB2XbE';
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio? _dio;

  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();
  Future<Directions?> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio!.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': _googleAPIKey,

      
    });
    debugPrint('${response.data}');
    if(response.statusCode == 200){
     return Directions.fromMap(response.data);
    }
    return null;
  }
}

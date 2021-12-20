import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localstorage/model/directions.dart';
import 'package:localstorage/repo/direction_repo.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              markers: {
                if (_origin != null) _origin!,
                if (_destination != null) _destination!,
              },
              onTap: _addMarker,
              onLongPress: _addMarker,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
            ),
            if (_info != null)
              Positioned(
                  top: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6)
                        ]),
                    child: Text(
                      '${_info!.totalDistance},${_info!.totalDistance}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _googleMapController.animateCamera((_info != null)
                ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
                : CameraUpdate.newCameraPosition(_initialCameraPosition));
            // _googleMapController.animateCamera(
            //     CameraUpdate.newCameraPosition(_initialCameraPosition));
          },
          child: const Icon(Icons.center_focus_strong),
        ),
      ),
    );
  }

  _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      _origin = Marker(
          position: pos,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'));
      _destination = null;
      _info = null;
      setState(() {});
    } else {
      _destination = Marker(
          markerId: const MarkerId('destination'),
          position: pos,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Destination'));

      if (_origin != null && _destination != null) {
        final directions = await DirectionRepository().getDirection(
            origin: _origin!.position, destination: _destination!.position);

        if (directions != null) {
          _info = directions;
        }
      }
      setState(() {});
    }
  }
}

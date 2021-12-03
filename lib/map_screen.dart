import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/position_cubit.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<PositionCubit, PositionState>(
        listener: (previousState, currentState) {
          if (currentState is PositionLoadedState) {
            _mapController.onReady
                .then((value) => _mapController.move(LatLng(currentState.latitude, currentState.longitude), 14));
          }
        },
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onLongPress: (tapPosition, latLng) {
              //TODO create note
            },
            center: LatLng(0, 0),
            zoom: 10,
            minZoom: 3.5,
            maxZoom: 17,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              retinaMode: true,
            ),
            // MarkerLayerOptions(
            //   markers: [
            //     Marker(
            //       width: 20.0,
            //       height: 20.0,
            //       point: LatLng(latitude, longitude),
            //       builder: (ctx) => const Icon(Icons.location_pin),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

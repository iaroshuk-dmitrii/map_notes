import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_notes/models/note_model.dart';

class MapWithMarkers extends StatelessWidget {
  MapWithMarkers({
    Key? key,
    required this.mapController,
    required this.onMapLongPress,
    required this.notes,
    required this.onMarkerTap,
  }) : super(key: key);

  final MapController mapController;
  List<Note> notes;
  final void Function(LatLng latLng) onMapLongPress;
  final void Function(Note note) onMarkerTap;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onLongPress: (tapPosition, latLng) => onMapLongPress(latLng),
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
        MarkerLayerOptions(markers: _buildMarkersList(context, notes: notes)),
      ],
    );
  }

  List<Marker> _buildMarkersList(BuildContext context, {required List<Note> notes}) {
    List<Marker> markers = [];
    for (var note in notes) {
      markers.add(Marker(
        height: 56,
        width: 100,
        point: LatLng(note.latitude, note.longitude),
        builder: (context) => GestureDetector(
          child: Column(
            children: [
              Text(
                note.title,
                style: const TextStyle(color: Colors.black),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Image.asset(
                'assets/images/note_icon.png',
                height: 40,
                width: 40,
              ),
            ],
          ),
          onTap: () => onMarkerTap(note),
        ),
      ));
    }
    return markers;
  }
}

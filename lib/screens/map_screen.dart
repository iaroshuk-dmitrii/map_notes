import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/screens/create_note_screen.dart';
import 'package:map_notes/business_logic/position_cubit.dart';
import 'package:map_notes/widgets/bottom_navigation_bar.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

  List<Marker> _buildMarkersList(BuildContext context, {required List<Note> notes}) {
    List<Marker> markers = [];
    for (var note in notes) {
      markers.add(Marker(
        height: 40,
        width: 20,
        point: LatLng(note.latitude, note.longitude),
        builder: (context) => Column(
          children: [
            const Icon(Icons.sticky_note_2_outlined),
            Text(note.title),
          ],
        ),
      ));
    }
    return markers;
  }

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
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<NoteCubit, NoteState>(
                builder: (context, noteState) {
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      onLongPress: (tapPosition, latLng) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateNoteScreen(
                                  latLng: latLng,
                                )));
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
                      MarkerLayerOptions(markers: _buildMarkersList(context, notes: noteState.notes)),
                    ],
                  );
                },
              ),
            ),
            MyBottomNavigationBar(
                navigationType: NavigationType.map,
                onPressedNotes: () {
                  //TODO
                }),
          ],
        ),
      ),
    );
  }
}

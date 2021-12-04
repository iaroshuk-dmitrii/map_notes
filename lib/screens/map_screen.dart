import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/screens/create_note_screen.dart';
import 'package:map_notes/business_logic/position_cubit.dart';
import 'package:map_notes/screens/help_screen.dart';
import 'package:map_notes/screens/note_info_screen.dart';
import 'package:map_notes/screens/notes_screen.dart';
import 'package:map_notes/widgets/bottom_navigation_bar.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

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
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteInfoScreen(note: note))),
        ),
      ));
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Stack(
                children: [
                  BlocBuilder<NoteCubit, NoteState>(
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
                  Positioned(
                    right: 10,
                    top: 20,
                    child: TextButton(
                      child: Icon(
                        Icons.help_outline,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 30,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surface),
                        shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(5)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpScreen()));
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: TextButton(
                      child: Icon(
                        Icons.my_location,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 30,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surface),
                        shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(5)),
                      ),
                      onPressed: () {
                        context.read<PositionCubit>().getPosition();
                      },
                    ),
                  ),
                ],
              ),
            ),
            MyBottomNavigationBar(
              navigationType: NavigationType.map,
              onPressedNotes: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const NotesScreen()), (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

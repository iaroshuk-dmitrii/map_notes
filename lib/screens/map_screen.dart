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
import 'package:map_notes/widgets/map_with_markers.dart';
import 'package:map_notes/widgets/positioned_icon_button.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PositionCubit, PositionState>(
        listener: (previousState, currentState) {
          if (currentState is PositionLoadedState) {
            _mapController.onReady.then((value) =>
                _mapController.moveAndRotate(LatLng(currentState.latitude, currentState.longitude), 15.5, 0));
          }
          if (currentState is PositionErrorState) {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Предоставьте приложению разрешение на доступ к вашему местоположению.',
                        textAlign: TextAlign.center),
                  ),
                );
              },
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<NoteCubit, NoteState>(
                    builder: (context, noteState) {
                      return MapWithMarkers(
                        notes: noteState.notes,
                        mapController: _mapController,
                        onMarkerTap: (Note note) => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => NoteInfoScreen(note: note))),
                        onMapLongPress: (LatLng latLng) => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateNoteScreen(
                                  latLng: latLng,
                                ))),
                      );
                    },
                  ),
                  PositionedIconButton(
                    right: 10,
                    top: 20,
                    icon: Icons.help_outline,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpScreen())),
                  ),
                  PositionedIconButton(
                    right: 10,
                    bottom: 10,
                    icon: Icons.my_location,
                    onPressed: () => context.read<PositionCubit>().getPosition(),
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

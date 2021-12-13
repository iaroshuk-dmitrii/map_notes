import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/widgets/note_editing_fields.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key, required this.latLng}) : super(key: key);

  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заметку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: NoteEditFields(
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          onConfirm: (note) {
            context.read<NoteCubit>().createNote(note);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/widgets/note_editing_fields.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить заметку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: NoteEditFields(
          id: note.id,
          title: note.title,
          description: note.description,
          latitude: note.latitude,
          longitude: note.longitude,
          onConfirm: (newNote) {
            context.read<NoteCubit>().updateNote(newNote);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

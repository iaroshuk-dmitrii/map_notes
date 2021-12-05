import 'package:flutter/material.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/screens/edit_note_screen.dart';
import 'package:map_notes/widgets/delete_note_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NoteInfoScreen extends StatelessWidget {
  const NoteInfoScreen({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              note.title,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              note.description,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              DateFormat().format(note.dateTime),
              style: const TextStyle(fontSize: 10),
            ),
          ),
          Expanded(child: Container()),
          ElevatedButton(
            child: const Text('Изменить заметку'),
            // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)));
              // context.read<NoteCubit>().updateNote(note);
              // Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Удалить заметку'),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () => deleteNoteDialog(
                context: context,
                onConfirm: () {
                  context.read<NoteCubit>().deleteNote(note);
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
    );
  }
}

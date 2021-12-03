import 'package:flutter/material.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:flutter/src/material/material_state.dart';
import 'package:provider/src/provider.dart';

class NoteInfoScreen extends StatelessWidget {
  const NoteInfoScreen({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(child: Container()),
          ElevatedButton(
            child: const Text('Удалить заметку'),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            onLongPress: () {
              context.read<NoteCubit>().deleteNote(note);
              Navigator.of(context).pop();
            },
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

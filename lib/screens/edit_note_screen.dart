import 'package:flutter/material.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerTitle = TextEditingController(text: note.title);
    TextEditingController _controllerDescription = TextEditingController(text: note.description);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить заметку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _controllerTitle,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: 'Заголовок',
              ),
            ),
            TextField(
              controller: _controllerDescription,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: 'Текст',
              ),
              minLines: 3,
              maxLines: 10,
            ),
            ElevatedButton(
              child: const Text('Сохранить'),
              onPressed: () {
                context.read<NoteCubit>().updateNote(Note(
                      id: note.id,
                      title: _controllerTitle.text,
                      description: _controllerDescription.text,
                      latitude: note.latitude,
                      longitude: note.longitude,
                      dateTime: DateTime.now(),
                    ));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

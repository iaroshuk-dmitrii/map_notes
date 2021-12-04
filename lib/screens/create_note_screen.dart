import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatelessWidget {
  final LatLng latLng;
  const CreateNoteScreen({Key? key, required this.latLng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerTitle = TextEditingController();
    TextEditingController _controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заметку'),
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
              child: const Text('Создать'),
              onPressed: () {
                Note note = Note(
                  title: _controllerTitle.text,
                  description: _controllerDescription.text,
                  latitude: latLng.latitude,
                  longitude: latLng.longitude,
                  dateTime: DateTime.now(),
                );
                context.read<NoteCubit>().createNote(note);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

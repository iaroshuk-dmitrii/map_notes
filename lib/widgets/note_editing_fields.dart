import 'package:flutter/material.dart';
import 'package:map_notes/models/note_model.dart';

class NoteEditFields extends StatefulWidget {
  const NoteEditFields({
    required this.latitude,
    required this.longitude,
    this.title,
    this.description,
    this.id,
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  final int? id;
  final double latitude;
  final double longitude;
  final String? title;
  final String? description;
  final void Function(Note note) onConfirm;

  @override
  _NoteEditFieldsState createState() => _NoteEditFieldsState();
}

class _NoteEditFieldsState extends State<NoteEditFields> {
  final FocusNode _descriptionFocusNode = FocusNode();
  late final TextEditingController _controllerTitle = TextEditingController(text: widget.title);
  late final TextEditingController _controllerDescription = TextEditingController(text: widget.description);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDescription.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controllerTitle,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          decoration: const InputDecoration(
            labelText: 'Заголовок',
          ),
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
        ),
        TextField(
          controller: _controllerDescription,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          decoration: const InputDecoration(
            labelText: 'Текст',
          ),
          focusNode: _descriptionFocusNode,
          minLines: 3,
          maxLines: 10,
        ),
        ElevatedButton(
          child: const Text('Сохранить'),
          onPressed: () {
            Note editedNote = Note(
              id: widget.id,
              title: _controllerTitle.text,
              description: _controllerDescription.text,
              latitude: widget.latitude,
              longitude: widget.longitude,
              dateTime: DateTime.now(),
            );
            widget.onConfirm(editedNote);
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/business_logic/note_cubit.dart';
import 'package:map_notes/business_logic/position_cubit.dart';
import 'package:map_notes/screens/map_screen.dart';
import 'package:map_notes/screens/note_info_screen.dart';
import 'package:map_notes/widgets/bottom_navigation_bar.dart';
import 'package:map_notes/widgets/delete_note_dialog.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NoteCubit, NoteState>(
              builder: (context, noteState) {
                return ListView.builder(
                  itemCount: noteState.notes.length,
                  itemBuilder: (context, i) {
                    int index = noteState.notes.length - 1 - i;
                    return Card(
                      child: ListTile(
                        title: Text(
                          noteState.notes[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          noteState.notes[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NoteInfoScreen(note: noteState.notes[index])),
                        ),
                        onLongPress: () => deleteNoteDialog(
                            context: context,
                            onConfirm: () {
                              context.read<NoteCubit>().deleteNote(noteState.notes[index]);
                            }),
                      ),
                      elevation: 5,
                    );
                  },
                );
              },
            ),
          ),
          MyBottomNavigationBar(
            navigationType: NavigationType.notes,
            onPressedMap: () {
              context.read<PositionCubit>().getPosition();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MapScreen()), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

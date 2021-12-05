import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/models/note_model.dart';
import 'package:map_notes/services/database.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteState([]));

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> loadNotes() async {
    List<Note> notes = [];
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    if (rows.isNotEmpty) {
      for (var row in rows) {
        notes.add(
          Note(
            id: row['id'],
            latitude: double.parse(row['latitude']),
            longitude: double.parse(row['longitude']),
            title: row['title'],
            description: row['description'],
            dateTime: DateTime.parse(row['dateTime']),
          ),
        );
      }
    }
    emit(NoteState(notes));
  }

  Future<void> createNote(Note note) async {
    List<Note> notes = state.notes;
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle: note.title,
      DatabaseHelper.columnDescription: note.description,
      DatabaseHelper.columnLatitude: note.latitude,
      DatabaseHelper.columnLongitude: note.longitude,
      DatabaseHelper.columnDateTime: note.dateTime.toIso8601String(),
    };
    note.id = await databaseHelper.insert(row);
    notes.add(note);
    emit(NoteState(notes));
  }

  Future<void> deleteNote(Note note) async {
    List<Note> notes = state.notes;
    notes.remove(note);
    await databaseHelper.delete(note.id!);
    emit(NoteState(notes));
  }

  Future<void> updateNote(Note newNote) async {
    List<Note> notes = state.notes;
    notes.removeWhere((note) => note.id == newNote.id);
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle: newNote.title,
      DatabaseHelper.columnDescription: newNote.description,
      DatabaseHelper.columnLatitude: newNote.latitude,
      DatabaseHelper.columnLongitude: newNote.longitude,
      DatabaseHelper.columnDateTime: newNote.dateTime.toIso8601String(),
    };
    await databaseHelper.update(newNote.id!, row);
    notes.add(newNote);
    emit(NoteState(notes));
  }
}

class NoteState {
  List<Note> notes;
  NoteState(this.notes);
}

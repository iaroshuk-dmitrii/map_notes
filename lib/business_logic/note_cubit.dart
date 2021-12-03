import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_notes/models/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteState([]));

  void createNote(Note note) {
    List<Note> notes = state.notes;
    notes.add(note);
    emit(NoteState(notes));
  }

  Future<void> deleteNote(Note note) async {
    //TODO
  }
}

class NoteState {
  List<Note> notes;
  NoteState(this.notes);
  //
  // @override
  // List<Object> get props => [notes];
}

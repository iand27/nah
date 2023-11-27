import 'package:flutter/material.dart';

import '../data/hive_database.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  //  hive database
  final db = HiveDatabase();

  // semua catatan
  List<Note> allNotes = [];

  // inisialisasi list
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  // get catatan
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add catatan baru
  void addNewNote(Note note) {
    allNotes.add(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }

  // update catatan
  void updateNote(Note note, String text, String time) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
        allNotes[i].time = time;
      }
    }
    db.savedNotes(allNotes);
    notifyListeners();
  }

  // hapus catatan
  void deleteNote(Note note) {
    allNotes.remove(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }
}

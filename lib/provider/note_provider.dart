import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/helper/Db.dart';
import 'package:notes/model/note_Model.dart';

class NoteProvider with ChangeNotifier {
  Db db = Db();
  List<NoteModel> notes = [];
  bool loading = false;

  Future<void> viewNotes(int folderId) async {
    loading = true;
    notifyListeners();

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    var response = await db.read('''
      SELECT * FROM notes WHERE userId = '$userId' AND folderId = '$folderId'
    ''');

    notes = response.map<NoteModel>((note) {
      return NoteModel.fromMap(note);
    }).toList();

    loading = false;
    notifyListeners();
  }
  Future<void> deleteNote(String noteId) async {
    int? id = int.tryParse(noteId);
    if(id != null){
      var response = await db.delete('''
      DELETE FROM `notes` WHERE idNote = '$id'
    ''');
      if (response > 0) {
        notes.removeWhere((note) => note.idNote == id);
        notifyListeners();
      }
    }
  }
}

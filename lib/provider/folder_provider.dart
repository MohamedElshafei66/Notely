import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/Db.dart';
import '../model/folder_Model.dart';

class FolderProvider with ChangeNotifier {
  Db db = Db();
  List<Folder> folders = [];
  bool loading = false;
  Future<void> getFolders() async {
    loading = true;
    notifyListeners();

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      List response = (await db.read(
        'SELECT * FROM folders WHERE userId = \'$userId\'',
      ));
      folders = response.map((e) => Folder.fromMap(e)).toList();
    }

    loading = false;
    notifyListeners();
  }
  Future<void> deleteFolder(String folderId) async {
    int? id = int.tryParse(folderId);
    if (id != null) {
      var response = await db.delete(
        'DELETE FROM folders WHERE id = $id',
      );
      if (response > 0) {
        folders.removeWhere((folder) => folder.id == id);
        notifyListeners();
      }
    }
  }

}

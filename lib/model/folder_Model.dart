class Folder {
  int? id;
  String folderName;
  String userId;

  Folder({
    this.id,
    required this.folderName,
    required this.userId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'folder': folderName,
      'userId': userId,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      folderName: map['folder'],
      userId: map['userId'],
    );
  }
}

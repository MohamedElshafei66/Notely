class NoteModel {
  int? idNote;
  String title;
  String content;
  String userId;
  int? folderId;

  NoteModel({
    this.idNote,
    required this.title,
    required this.content,
    required this.userId,
    this.folderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'idNote': idNote,
      'title': title,
      'content': content,
      'userId': userId,
      'folderId': folderId,
    };
  }
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      idNote: map['idNote'],
      title: map['title'],
      content: map['content'],
      userId: map['userId'],
      folderId: map['folderId'],
    );
  }
}

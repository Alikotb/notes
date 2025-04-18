
class NotesModel{
  final int id;
  final String title;
  final String content;
  final String date;
  bool isImportant;
  NotesModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
     this.isImportant=false,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'isImportant': isImportant ? 1 : 0,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      isImportant: map['isImportant'] == 1,
    );
  }

}
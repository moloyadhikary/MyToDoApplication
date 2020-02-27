class Task {
  final int id;
  final int typeId;
  final String title;
  final String description;
  final DateTime createDate;
  final DateTime updateDate;
  final bool isCompleted;
  final String typeTitle;

  Task({
    this.id,
    this.typeId,
    this.title,
    this.description,
    this.createDate,
    this.updateDate,
    this.isCompleted,
    this.typeTitle,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        typeId: json["typeId"],
        title: json["title"],
        description: json["description"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        isCompleted: json["isCompleted"] == 1 ? true : false,
        typeTitle: json["typeTitle"],
      );
}

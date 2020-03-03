class SubTask {
  final int id;
  final int taskId;
  String title;
  String description;
  final DateTime createDate;
  final DateTime updateDate;
  final bool isCompleted; 


  SubTask({
    this.id,
    this.taskId,
    this.title,
    this.description,
    this.createDate,
    this.updateDate,
    this.isCompleted,
  });

  factory SubTask.fromMap(Map<String, dynamic> json) => new SubTask(
        id: json["id"],
        taskId: json["taskId"],
        title: json["title"],
        description: json["description"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        isCompleted: json["isCompleted"] == 1 ? true : false,
      );
}

class Tasktypes {
  final int id;
  String title;
  String description;


  Tasktypes({this.id, this.title, this.description});


  factory Tasktypes.fromMap(Map<String, dynamic> json) => new Tasktypes(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );
}
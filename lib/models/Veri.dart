class Veri {
  int userId;
  int id;
  String title;
  String body;

  Veri.fromJsonMap(Map<String, dynamic> map)
      : userId = map["userId"],
        id = map["id"],
        title = map["title"],
        body = map["body"];
}

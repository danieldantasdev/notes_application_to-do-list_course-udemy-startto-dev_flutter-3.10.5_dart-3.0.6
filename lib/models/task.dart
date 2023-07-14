class Task {
  Task({required this.title, required this.datetime});

  String title;
  DateTime datetime;

  Task.FromJson(Map<String, dynamic> json)
      : title = json['title'],
        datetime = DateTime.parse(json['datetime']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': datetime.toIso8601String(),
    };
  }
}

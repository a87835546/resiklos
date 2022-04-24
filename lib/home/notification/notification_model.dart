class NotificationModel {
  int? id;
  num? type;
  String? description;
  String? content;

  NotificationModel({this.id, this.type, this.description, this.content});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    NotificationModel model = NotificationModel(
        id: json["id"],
        type: json["type"],
        description: json["description"],
        content: json["content"]);
    return model;
  }

  @override
  String toString() {
    return 'NotificationModel{id: $id, type: $type, description: $description, content: $content}';
  }
}

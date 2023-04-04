class History {
  int id;
  String operationType;
  String objectType;
  String objectName;
  DateTime date;

  History({
    this.id,
    this.operationType,
    this.objectType,
    this.date,
    this.objectName,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json["id"] as int,
      operationType: json["operationType"] as String,
      objectType: json["objectType"] as String,
      objectName: json["objectName"] as String,
      date: DateTime.parse(json["dateTimeOperation"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "operationType": operationType,
      "objectType": objectType,
      "objectName": objectName,
      "dateTimeOperation": date.toIso8601String(),
    };
  }
}
class History {
  int id;
  String operationType;
  String entitiesType;
  DateTime date;

  History({
    this.id,
    this.operationType,
    this.entitiesType,
    this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json["id"] as int,
      operationType: json["operationType"] as String,
      entitiesType: json["entitiesType"] as String,
      date: DateTime.parse(json["dateTimeOperation"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "operationType": operationType,
      "entitiesType": entitiesType,
      "dateTimeOperation": date.toIso8601String(),
    };
  }
}
class History {
  int id;
  String operationType;
  String entityType;
  String objectName;
  String operationCode;
  DateTime date;

  History({
    this.id,
    this.operationType,
    this.entityType,
    this.date,
    this.objectName,
    this.operationCode,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json["id"] as int,
      operationType: json["operationType"] as String,
      entityType: json["entityType"] as String,
      objectName: json["objectName"] as String,
      date: DateTime.parse(json["dateTimeOperation"] as String),
      operationCode: json["operationCode"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "operationType": operationType,
      "entityType": entityType,
      "objectName": objectName,
      "dateTimeOperation": date.toIso8601String(),
      "operationCode": operationCode,
    };
  }
}
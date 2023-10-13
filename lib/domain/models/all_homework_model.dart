import 'dart:convert';

class AllHomeWorkModel {
  final Assignment? group;
  final Assignment? assignment;

  AllHomeWorkModel({
    this.group,
    this.assignment,
  });

  factory AllHomeWorkModel.fromRawJson(String str) => AllHomeWorkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllHomeWorkModel.fromJson(Map<String, dynamic> json) => AllHomeWorkModel(
    group: json["group"] == null ? null : Assignment.fromJson(json["group"]),
    assignment: json["assignment"] == null ? null : Assignment.fromJson(json["assignment"]),
  );

  Map<String, dynamic> toJson() => {
    "group": group?.toJson(),
    "assignment": assignment?.toJson(),
  };
}

class Assignment {
  final int? id;
  final String? name;

  Assignment({
    this.id,
    this.name,
  });

  factory Assignment.fromRawJson(String str) => Assignment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

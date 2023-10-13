import 'dart:convert';

class Result {
  final String? firstName;
  final String? lastName;
  final String? github;
  final List<Task>? tasks;

  Result({
    this.firstName,
    this.lastName,
    this.github,
    this.tasks,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        firstName: json["first_name"],
        lastName: json["last_name"],
        github: json["github"],
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "github": github,
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Task {
  final String? name;
  final int? attempts;
  final bool? isCorrect;

  Task({
    this.name,
    this.attempts,
    this.isCorrect,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
        attempts: json["attempts"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "attempts": attempts,
        "is_correct": isCorrect,
      };
}

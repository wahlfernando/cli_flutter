import 'dart:convert';

class CoursesModel {
  int? id;
  String name;
  bool isStudent;
  CoursesModel({
    this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursesModel.fromJson(String source) =>
      CoursesModel.fromMap(json.decode(source));
}

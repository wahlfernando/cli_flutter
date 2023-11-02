import 'dart:convert';

import 'address_model.dart';
import 'courses_model.dart';

class StudentsModel {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<CoursesModel> courses;
  final AddressModel address;

  StudentsModel({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((x) => x.toMap()).toList(),
      'address': address.toMap(),
    };
  }

  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      age: map['age']?.toInt(),
      nameCourses: List<String>.from(map['nameCourses'] ?? <String>[]),
      courses: List<CoursesModel>.from(
          map['courses']?.map((courses) => CoursesModel.fromMap(courses)) ??
              <CoursesModel>[]),
      address: AddressModel.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentsModel.fromJson(String source) =>
      StudentsModel.fromMap(json.decode(source));
}

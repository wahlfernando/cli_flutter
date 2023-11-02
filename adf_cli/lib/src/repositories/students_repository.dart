import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/students_model.dart';

class StudentsRepository {
  Future<List<StudentsModel>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    final studentsData = jsonDecode(studentsResult.body);

    return studentsData.map<StudentsModel>((student) {
      return StudentsModel.fromMap(student);
    }).toList();
  }

  Future<StudentsModel> findById(int id) async {
    final studentResult =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResult.statusCode != 200 || studentResult.body == '{}') {
      throw Exception();
    }

    return StudentsModel.fromJson(studentResult.body);
  }

  Future<void> insert(StudentsModel studentsModel) async {
    final resposnse = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: studentsModel.toJson(),
        headers: {'content-type': 'application/json'});

    if (resposnse.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(StudentsModel studentsModel) async {
    final response = await http.put(
        Uri.parse('http://localhost:8080/students/${studentsModel.id}'),
        body: studentsModel.toJson(),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> delete(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}

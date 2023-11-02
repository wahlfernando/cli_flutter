import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/students_model.dart';

class StudentsDioRepository {
  Future<List<StudentsModel>> findAll() async {
    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');

      return studentsResult.data.map<StudentsModel>((student) {
        return StudentsModel.fromMap(student);
      }).toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<StudentsModel> findById(int id) async {
    try {
      final studentResult =
          await Dio().get('http://localhost:8080/students/$id');

      if (studentResult.data == null) {
        throw Exception('Usuário inesxistente ou erro na API.');
      }

      return StudentsModel.fromMap(studentResult.data);
    } on DioException catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> insert(StudentsModel studentsModel) async {
    try {
      Dio().post('http://localhost:8080/students', data: studentsModel.toMap());
    } on DioException catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> update(StudentsModel studentsModel) async {
    try {
      Dio().put('http://localhost:8080/students/${studentsModel.id}', data: studentsModel.toMap());
    } on DioException catch (e) {
      log(e.toString());
      throw Exception();
    }
    
  }

  Future<void> delete(int id) async {
    try {
      Dio().delete('http://localhost:8080/students/$id}');
    } on DioException catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}

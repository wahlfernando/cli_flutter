import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/students_model.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class InsertCommand extends Command {
  final StudentsRepository repository;
  final ProductRepository productRepository;

  InsertCommand({required this.repository})
      : productRepository = ProductRepository() {
    argParser.addOption('file', help: 'Ecolha o arquivo CSV', abbr: 'f');
  }

  @override
  String get description => 'Insert Students';

  @override
  String get name => 'insert';

  @override
  run() async {
    print('Aguarde.. iniciando cadastro em bloco..');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('--------------------------------------------------');

    for (var student in students) {
      print('Realizando cadastro.. ');
      final studentsData = student.split(';');
      final courseCsv =
          studentsData[2].split(',').map((e) => e.trim()).toList();

      final courseFeatures = courseCsv.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(courseFeatures);

      final studentsModel = StudentsModel(
        name: studentsData[0],
        age: int.parse(studentsData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: AddressModel(
          street: studentsData[3],
          number: int.parse(studentsData[4]),
          zipCode: studentsData[5],
          city: CityModel(id: 1, name: studentsData[6]),
          phone: PhoneModel(
            ddd: int.parse(studentsData[7]),
            phone: studentsData[8],
          ),
        ),
      );

      await repository.insert(studentsModel);
      print('Aluno ${studentsData[0]} cadstrado com sucesso!');
      print('===================================');
    }
    print('----------------------------------------------');
    print('Todos os alunos foram cadastrados');
  }
}

import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/students_model.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class UpdateCommand extends Command {
  StudentsRepository studentsRepository;

  final productRepository = ProductRepository();

  @override
  String get description => 'Update coammand';

  @override
  String get name => 'update';

  UpdateCommand({required this.studentsRepository}) {
    argParser.addOption('file', help: 'Ecolha o arquivo CSV', abbr: 'f');
    argParser.addOption('id', help: 'Utudent ID', abbr: 'i');
  }

  @override
  run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informa o id do aluno');
      return false;
    }

    final students = File(filePath).readAsLinesSync();
    print('Atualizando cadastro');
    print('--------------------------------------------------');

    if (students.length > 1) {
      print('Por favor informe o id do um aluno somente..');
    } else if (students.isEmpty) {
      print('Por favor informe o id no arquivo $filePath');
    }

    final student = students.first;
    
    final studentsData = student.split(';');
    final courseCsv = studentsData[2].split(',').map((e) => e.trim()).toList();

    final courseFeatures = courseCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFeatures);

    final studentsModel = StudentsModel(
      id: int.parse(id),
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

    await studentsRepository.update(studentsModel);
    print('Aluno ${studentsData[0]} atualizado com sucesso!');
    print('----------------------------------------------');
    print('Todos os alunos foram cadastrados');
  }
}

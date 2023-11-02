import 'dart:io';

import 'package:args/command_runner.dart';
import '../../../repositories/students_repository.dart';

class FindAllCommand extends Command {
  final StudentsRepository repository;

  FindAllCommand({required this.repository});

  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  @override
  run() async {
    print('Aguarde.. buscando alunos...');
    final students = await repository.findAll();
    print('Apresentar tbm os cursos?(  S ou N)');
    final showCourses = stdin.readLineSync();
    print('----------------------------------------');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
            '${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
    print('----------------------------------------');
  }
}

import 'package:args/command_runner.dart';

import '../../../repositories/students_repository.dart';

class FindByIdCommand extends Command{

  final StudentsRepository repository;

  FindByIdCommand({required this.repository}){
    argParser.addOption('id', help: 'Students ID', abbr: 'i');
  }

  @override
  String get description => 'Find Students By ID';

  @override
  String get name => 'byId';

  @override
  run() async {
    
    if (argResults?['id'] == null) {
      print('Por favor passar o id do aluno');
      return false;
    }

    final id = int.parse(argResults?['id']);

    print('Aguarde.. buscando alunos...');
    final students = await repository.findById(id);
    print('----------------------------------------');
    print(' Aluno ${students.name}');
    print('----------------------------------------');
    print('Nome: ${students.name}');
    print('Idade: ${students.age}');
    print('Curso: ');
    students.nameCourses.forEach(print);
    print('Endereço: ${students.name}');
    print('   ${students.address.street} - ${students.address.zipCode}');
    print('----------------------------------------');




  }
  
}
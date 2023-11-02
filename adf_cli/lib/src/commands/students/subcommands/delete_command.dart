
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/students_repository.dart';

class DeleteCommand extends Command {
  
  StudentsRepository studentsRepository;

  @override
  String get description => 'Deletando Usuário';

  @override
  String get name => 'delete';

  DeleteCommand({
    required this.studentsRepository,
  }){
    argParser.addOption('id', help: 'Utudent ID', abbr: 'i');
  }

  @override
  run() async {
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informa o id do aluno');
      return false;
    }
    print('Deletando Usuário');
    print('--------------------------------------------------');
    
    print('Deseja realmente deletar o usuário?(S ou N)');
    final resposnse = stdin.readLineSync();
    print('----------------------------------------');
    if (resposnse?.toLowerCase() == 's') {
        print('Deletando..');
        await studentsRepository.delete(int.parse(id));
      } else {
        print('Cancelado pelo usuário..');
        return false;
      }
    print('----------------------------------------------');
    print('Aluno deletado');
  }
}

import 'package:args/command_runner.dart';

import '../../repositories/students_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operation';

  @override
  String get name => 'students';

  StudentsCommand() {
    final studentsRepository = StudentsRepository();
    addSubcommand(
      FindAllCommand(
        repository: studentsRepository,
      ),
    );
    addSubcommand(
      FindByIdCommand(
        repository: studentsRepository,
      ),
    );
    addSubcommand(
      InsertCommand(
        repository: studentsRepository,
      ),
    );
    addSubcommand(
      UpdateCommand(
        studentsRepository: studentsRepository,
      ),
    );
    addSubcommand(
      DeleteCommand(
        studentsRepository: studentsRepository,
      ),
    );
  }
}

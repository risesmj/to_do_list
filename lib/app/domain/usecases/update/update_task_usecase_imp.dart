import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';

import 'update_task_usecase.dart';

class UpdateTaskUsecaseImp implements UpdateTaskUsecase {
  final ToDoListRepository repository;

  UpdateTaskUsecaseImp({required this.repository});

  @override
  Future<bool> call(TaskEntity task) => repository.update(task);
}

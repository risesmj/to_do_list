import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';

class CreateTaskUsecaseImp implements CreateTaskUsecase {
  final ToDoListRepository repository;

  CreateTaskUsecaseImp({required this.repository});

  @override
  Future<bool> call(TaskEntity task) => repository.create(task);
}

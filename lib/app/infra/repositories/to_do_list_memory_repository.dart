import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';

class ToDoListMemoryRepository implements ToDoListRepository {
  final listMemory = <TaskEntity>[];

  @override
  bool create(TaskEntity task) {
    listMemory.add(task);
    return true;
  }

  @override
  List<TaskEntity> get() => listMemory;

  @override
  bool update(TaskEntity task) {
    final index = listMemory.indexWhere((element) => element.id == task.id);

    if (index > -1) {
      listMemory[index] = task;
      return true;
    } else {
      return false;
    }
  }
}

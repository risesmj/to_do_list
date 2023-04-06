import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/infra/datasource/to_do_list_datasource.dart';

class ToDoListMemoryDatasource implements ToDoListDatasource {
  final listMemory = <TaskEntity>[];

  @override
  Future<bool> create(TaskEntity task) async {
    listMemory.add(task);
    return true;
  }

  @override
  Future<List<TaskEntity>> get() async => listMemory;

  @override
  Future<bool> update(TaskEntity task) async {
    final index = listMemory.indexWhere((element) => element.id == task.id);

    if (index > -1) {
      listMemory[index] = task;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> markOrDemark(String id, bool flag) async {
    final index = listMemory.indexWhere((element) => element.id == id);

    if (index > -1) {
      listMemory[index].done = flag;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> removeAt(String id) async {
    final index = listMemory.indexWhere((element) => element.id == id);

    if (index > -1) {
      listMemory.removeAt(index);
      return true;
    } else {
      return false;
    }
  }
}

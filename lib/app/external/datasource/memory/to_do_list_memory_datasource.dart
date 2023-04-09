import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/exceptions/to_do_list_exception.dart';
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
    try {
      final index = listMemory.indexWhere((element) => element.id == task.id);

      if (index > -1) {
        listMemory[index] = task;
        return true;
      } else {
        throw TaskNotFoundToDoListException(
            'Não localizado a tarefa ${task.id}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> markOrDemark(String id, bool flag) async {
    try {
      final index = listMemory.indexWhere((element) => element.id == id);

      if (index > -1) {
        listMemory[index].done = flag;
        return true;
      } else {
        throw TaskNotFoundToDoListException('Não localizado a tarefa $id');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeAt(String id) async {
    try {
      final index = listMemory.indexWhere((element) => element.id == id);

      if (index > -1) {
        listMemory.removeAt(index);
        return true;
      } else {
        throw TaskNotFoundToDoListException('Não localizado a tarefa $id');
      }
    } catch (e) {
      rethrow;
    }
  }
}

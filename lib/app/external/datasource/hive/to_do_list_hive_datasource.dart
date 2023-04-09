import 'package:hive/hive.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/exceptions/to_do_list_exception.dart';
import 'package:to_do_list/app/infra/datasource/to_do_list_datasource.dart';

class ToDoListHiveDatasource implements ToDoListDatasource {
  @override
  Future<bool> create(TaskEntity task) async {
    try {
      final hive = await Hive.openBox<TaskEntity>('tasks');
      hive.add(task);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskEntity>> get() async {
    try {
      final hive = await Hive.openBox<TaskEntity>('tasks');
      final list = hive.values.toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> markOrDemark(String id, bool flag) async {
    try {
      final hive = await Hive.openBox<TaskEntity>('tasks');
      final list = hive.values.toList();
      final index = list.indexWhere((e) => e.id == id);

      if (index >= 0) {
        final task = list[index];
        task.done = flag;
        hive.put(task.key, task);
        return true;
      } else {
        throw TaskNotFoundToDoListException('Não localizado a tarefa $id');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update(TaskEntity task) async {
    try {
      final hive = await Hive.openBox<TaskEntity>('tasks');
      final list = hive.values.toList();
      final index = list.indexWhere((e) => e.id == task.id);

      if (index >= 0) {
        hive.put(list[index].key, task);
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
  Future<bool> removeAt(String id) async {
    try {
      final hive = await Hive.openBox<TaskEntity>('tasks');
      final list = hive.values.toList();
      final index = list.indexWhere((e) => e.id == id);

      if (index >= 0) {
        hive.delete(list[index].key);
        return true;
      } else {
        throw TaskNotFoundToDoListException('Não localizado a tarefa $id');
      }
    } catch (e) {
      rethrow;
    }
  }
}

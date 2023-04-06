import 'package:hive/hive.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/infra/datasource/to_do_list_datasource.dart';

class ToDoListHiveDatasource implements ToDoListDatasource {
  @override
  Future<bool> create(TaskEntity task) async {
    final hive = await Hive.openBox<TaskEntity>('tasks');
    hive.add(task);
    return true;
  }

  @override
  Future<List<TaskEntity>> get() async {
    final hive = await Hive.openBox<TaskEntity>('tasks');
    final list = hive.values.toList();
    return list;
  }

  @override
  Future<bool> markOrDemark(String id, bool flag) async {
    final hive = await Hive.openBox<TaskEntity>('tasks');
    final list = hive.values.toList();
    final index = list.indexWhere((e) => e.id == id);

    if (index >= 0) {
      final task = list[index];
      task.done = flag;
      hive.put(index, task);
    } else {
      return false;
    }

    return true;
  }

  @override
  Future<bool> update(TaskEntity task) async {
    final hive = await Hive.openBox<TaskEntity>('tasks');
    final index = hive.values.toList().indexWhere((e) => e.id == task.id);

    if (index >= 0) {
      hive.put(index, task);
    } else {
      return false;
    }

    return true;
  }

  @override
  Future<bool> removeAt(String id) async {
    final hive = await Hive.openBox<TaskEntity>('tasks');
    final index = hive.values.toList().indexWhere((e) => e.id == id);

    if (index >= 0) {
      hive.deleteAt(index);
    } else {
      return false;
    }

    return true;
  }
}

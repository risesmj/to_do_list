import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class ToDoListRepository {
  Future<List<TaskEntity>> get();
  Future<bool> create(TaskEntity task);
  Future<bool> update(TaskEntity task);
  Future<bool> markOrDemark(String id, bool flag);
  Future<bool> removeAt(String id);
}

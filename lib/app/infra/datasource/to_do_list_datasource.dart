import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class ToDoListDatasource {
  Future<bool> create(TaskEntity task);
  Future<List<TaskEntity>> get();
  Future<bool> markOrDemark(String id, bool flag);
  Future<bool> update(TaskEntity task);
  Future<bool> removeAt(String id);
}

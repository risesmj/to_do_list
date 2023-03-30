import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class ToDoListRepository {
  List<TaskEntity> get();
  bool create(TaskEntity task);
  bool update(TaskEntity task);
}

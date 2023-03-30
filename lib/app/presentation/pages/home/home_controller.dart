import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/to_do_list_usecase.dart';

class HomeController {
  final ToDoListUsecase getUsecase;
  final ToDoListUsecase updateUsecase;

  HomeController({
    required this.updateUsecase,
    required this.getUsecase,
  });

  List<TaskEntity> currentList = [];

  void fetch() {
    currentList = getUsecase.call();
  }

  void markOrDesmarkTask(bool b, int index) {
    final currentTask = currentList[index];

    final task = TaskEntity(
      id: currentTask.id,
      done: b,
      description: currentTask.description,
    );

    if (updateUsecase.call(params: task)) {
      currentList[index] = task;
    }
  }
}

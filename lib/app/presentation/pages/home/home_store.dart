import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase.dart';

class HomeStore extends StreamStore<String, List<TaskEntity>> {
  final GetListUsecase getUsecase;
  final MarkTaskUsecase markTaskUsecase;
  final RemoveAtUsecase removeAtUsecase;

  HomeStore({
    required this.markTaskUsecase,
    required this.getUsecase,
    required this.removeAtUsecase,
  }) : super([]);

  Future<void> fetch() async {
    setLoading(true);
    try {
      final list = await getUsecase();
      update(list);
    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  }

  void markOrDesmarkTask(bool b, int index) async {
    setLoading(true);
    final currentTask = state[index];

    final task = TaskEntity(
      id: currentTask.id,
      done: b,
      description: currentTask.description,
    );

    try {
      if (await markTaskUsecase.call(task.id, b)) {
        state[index] = task;
        update(List.from(state));
      }
    } catch (e) {
      setError(e.toString(), force: true);
    }

    setLoading(false);
  }

  void removeAt(int index) async {
    final currentTask = state[index];

    try {
      if (await removeAtUsecase(currentTask.id)) {
        fetch();
      }
    } catch (e) {
      setError(e.toString());
    }
  }
}

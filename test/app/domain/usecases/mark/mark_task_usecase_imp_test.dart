import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:modular_test/modular_test.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUp(() {
    Hive
      ..init(Directory.current.path)
      ..registerAdapter(
        TaskEntityAdapter(),
      );

    initModule(AppModule());
  });

  test('mark task usecase imp', () async {
    final id = const Uuid().v4();
    var result = false;

    final CreateTaskUsecase createTaskUsecase = Modular.get();
    final newTask = TaskEntity(
      id: id,
      done: false,
      description: 'Teste unitário Mark Task',
    );

    result = await createTaskUsecase(newTask);

    expect(result, true);

    final MarkTaskUsecase markTaskUsecase = Modular.get();

    result = await markTaskUsecase(id, true);

    expect(result, true);
  });
}

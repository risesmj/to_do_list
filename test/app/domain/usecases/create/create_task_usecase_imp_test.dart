import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:modular_test/modular_test.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';
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

  test('create task usecase imp', () async {
    final CreateTaskUsecase createTaskUsecase = Modular.get();
    final task = TaskEntity(
      id: const Uuid().v4(),
      done: false,
      description: 'Teste unitário',
    );

    final result = await createTaskUsecase(task);

    expect(result, true);
  });
}

import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:modular_test/modular_test.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase.dart';
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

  test('Get list usecase imp', () async {
    var resultCreateTaskUsecase = false;
    final CreateTaskUsecase createTaskUsecase = Modular.get();
    final task = TaskEntity(
      id: const Uuid().v4(),
      done: false,
      description: 'Teste unitário',
    );

    resultCreateTaskUsecase = await createTaskUsecase(task);

    expect(resultCreateTaskUsecase, true);

    final GetListUsecase getListUsecase = Modular.get();
    final resultGetListUsecase = await getListUsecase();
    expect(resultGetListUsecase, isNotEmpty);
  });
}

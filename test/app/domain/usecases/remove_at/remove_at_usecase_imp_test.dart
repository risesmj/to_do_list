import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:modular_test/modular_test.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/exceptions/to_do_list_exception.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUp(() {
    Hive
      ..init(Directory.current.path)
      ..registerAdapter(
        TaskEntityAdapter(),
        override: true,
      );

    initModule(AppModule());
  });

  group('Remove At Usecase Imp', () {
    test('Success', () async {
      final id = const Uuid().v4();
      var result = false;

      final CreateTaskUsecase createTaskUsecase = Modular.get();
      final newTask = TaskEntity(
        id: id,
        done: false,
        description: 'Teste unitário Remove At',
      );

      result = await createTaskUsecase(newTask);

      expect(result, true);

      final RemoveAtUsecase removeAtUsecase = Modular.get();

      result = await removeAtUsecase(id);

      expect(result, true);
    });

    test('Exception TaskNotFoundToDoListException',
        () async {
      final id = const Uuid().v4();

      final RemoveAtUsecase removeAtUsecase = Modular.get();

      expect(() async => await removeAtUsecase(id),
          throwsA(isA<TaskNotFoundToDoListException>()));
    });
  });
}

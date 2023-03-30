import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/create_task_usecase.dart';
import 'package:uuid/uuid.dart';

class RecordController {
  late final CreateTaskUsecase createUsecase;

  var currentDescription = "";

  RecordController({
    required this.createUsecase,
  });

  onChangeDescription(s) {
    currentDescription = s;
  }

  save() {
    final task = TaskEntity(
      id: const Uuid().v4(),
      done: false,
      description: currentDescription,
    );

    createUsecase.call(params: task);
  }
}

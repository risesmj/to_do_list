import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class CreateTaskUsecase {
  Future<bool> call(TaskEntity task);
}

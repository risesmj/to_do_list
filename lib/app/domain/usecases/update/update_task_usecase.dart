import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class UpdateTaskUsecase {
  Future<bool> call(TaskEntity task);
}

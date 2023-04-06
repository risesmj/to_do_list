import 'package:to_do_list/app/domain/entities/task_entity.dart';

abstract class GetListUsecase {
  Future<List<TaskEntity>> call();
}

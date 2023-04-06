import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase.dart';

class MarkTaskUsecaseImp implements MarkTaskUsecase {
  final ToDoListRepository repository;

  MarkTaskUsecaseImp({required this.repository});

  @override
  Future<bool> call(String id, bool flag) {
    return repository.markOrDemark(id, flag);
  }
}

import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase.dart';

class RemoveAtUsecaseImp implements RemoveAtUsecase {
  final ToDoListRepository repository;

  RemoveAtUsecaseImp({required this.repository});

  @override
  Future<bool> call(String id) {
    return repository.removeAt(id);
  }
}

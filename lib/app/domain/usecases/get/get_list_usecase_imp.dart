import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase.dart';

class GetListUsecaseImp implements GetListUsecase {
  final ToDoListRepository repository;

  GetListUsecaseImp({required this.repository});

  @override
  Future<List<TaskEntity>> call() => repository.get();
}

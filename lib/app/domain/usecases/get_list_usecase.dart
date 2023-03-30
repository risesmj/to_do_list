import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/to_do_list_usecase.dart';

class GetListUsecase implements ToDoListUsecase<List<TaskEntity>> {
  final ToDoListRepository repository;

  GetListUsecase({required this.repository});

  @override
  List<TaskEntity> call({params}) => repository.get();
}

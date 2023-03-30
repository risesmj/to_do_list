import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/to_do_list_usecase.dart';

class UpdateTaskUsecase implements ToDoListUsecase<bool> {
  final ToDoListRepository repository;

  UpdateTaskUsecase({required this.repository});

  @override
  bool call({params}) => repository.update(params);
}

import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/exceptions/to_do_list_exception.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/infra/datasource/to_do_list_datasource.dart';

class ToDoListRepositoryImp implements ToDoListRepository {
  final ToDoListDatasource datasource;

  ToDoListRepositoryImp({
    required this.datasource,
  });

  @override
  Future<bool> create(TaskEntity task) async {
    try {
      return await datasource.create(task);
    } on ToDoListException {
      rethrow;
    } catch (e) {
      throw UnknownToDoListException('Erro desconhecido');
    }
  }

  @override
  Future<List<TaskEntity>> get() async {
    try {
      return await datasource.get();
    } on ToDoListException {
      rethrow;
    } catch (e) {
      throw UnknownToDoListException('Erro desconhecido');
    }
  }

  @override
  Future<bool> markOrDemark(String id, bool flag) async {
    try {
      return datasource.markOrDemark(id, flag);
    } on ToDoListException {
      rethrow;
    } catch (e) {
      throw UnknownToDoListException('Erro desconhecido');
    }
  }

  @override
  Future<bool> update(TaskEntity task) async {
    try {
      return datasource.update(task);
    } on ToDoListException {
      rethrow;
    } catch (e) {
      throw UnknownToDoListException('Erro desconhecido');
    }
  }

  @override
  Future<bool> removeAt(String id) async {
    try {
      return datasource.removeAt(id);
    } on ToDoListException {
      rethrow;
    } catch (e) {
      throw UnknownToDoListException('Erro desconhecido');
    }
  }
}

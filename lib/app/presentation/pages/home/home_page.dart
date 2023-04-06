import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase_imp.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase_imp.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase_imp.dart';
import 'package:to_do_list/app/external/datasource/hive/to_do_list_hive_datasource.dart';
import 'package:to_do_list/app/infra/repositories/to_do_list_repository_imp.dart';
import 'package:to_do_list/app/presentation/pages/home/home_controller.dart';
import 'package:to_do_list/app/presentation/pages/home/home_store.dart';
import 'package:to_do_list/app/presentation/pages/record/record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  late final ToDoListRepository repository;

  @override
  void initState() {
    super.initState();

    repository = ToDoListRepositoryImp(
      datasource: ToDoListHiveDatasource(),
    );

    controller = HomeController(
        store: HomeStore(
      removeAtUsecase: RemoveAtUsecaseImp(
        repository: repository,
      ),
      markTaskUsecase: MarkTaskUsecaseImp(
        repository: repository,
      ),
      getUsecase: GetListUsecaseImp(
        repository: repository,
      ),
    ));

    controller.store.fetch();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do List')),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => RecordPage(repository: repository)),
              ),
            );
            controller.store.fetch();
          }),
      body: Center(
        child: TripleBuilder<HomeStore, String, List<TaskEntity>>(
          store: controller.store,
          builder: ((context, triple) {
            if (triple.isLoading) {
              return const CircularProgressIndicator();
            }

            if (triple.error != null) {
              return Text(triple.error!);
            }

            return ListView.builder(
                itemCount: triple.state.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                      leading: Checkbox(
                          value: triple.state[index].done,
                          onChanged: (b) {
                            controller.store.markOrDesmarkTask(b!, index);
                            setState(() {});
                          }),
                      title: Text(triple.state[index].description),
                      subtitle: Text(triple.state[index].id),
                      trailing: IconButton(
                        onPressed: () {
                          controller.store.removeAt(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ));
          }),
        ),
      ),
    );
  }
}

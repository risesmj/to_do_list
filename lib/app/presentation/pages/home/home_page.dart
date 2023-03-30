import 'package:flutter/material.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/get_list_usecase.dart';
import 'package:to_do_list/app/domain/usecases/update_task_usecase.dart';
import 'package:to_do_list/app/infra/repositories/to_do_list_memory_repository.dart';
import 'package:to_do_list/app/presentation/pages/home/home_controller.dart';
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

    repository = ToDoListMemoryRepository();

    controller = HomeController(
      updateUsecase: UpdateTaskUsecase(
        repository: repository,
      ),
      getUsecase: GetListUsecase(
        repository: repository,
      ),
    );

    controller.fetch();
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
            controller.fetch();
            setState(() {});
          }),
      body: ListView.builder(
        itemCount: controller.currentList.length,
        itemBuilder: _builderItemList,
      ),
    );
  }

  Widget _builderItemList(BuildContext context, int index) => ListTile(
        leading: Checkbox(
            value: controller.currentList[index].done,
            onChanged: (b) {
              controller.markOrDesmarkTask(b!, index);
              setState(() {});
            }),
        title: Text(controller.currentList[index].description),
        subtitle: Text(controller.currentList[index].id),
      );
}

import 'package:flutter/material.dart';
import 'package:to_do_list/app/domain/repositories/to_do_list_repository.dart';
import 'package:to_do_list/app/domain/usecases/create_task_usecase.dart';
import 'package:to_do_list/app/presentation/pages/record/record_controller.dart';

class RecordPage extends StatefulWidget {
  final ToDoListRepository repository;

  const RecordPage({
    required this.repository,
    super.key,
  });

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late final RecordController controller;

  @override
  void initState() {
    super.initState();

    controller = RecordController(
      createUsecase: CreateTaskUsecase(
        repository: widget.repository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: controller.onChangeDescription,
                  decoration: const InputDecoration(
                    label: Text('Descrição'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      controller.save();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

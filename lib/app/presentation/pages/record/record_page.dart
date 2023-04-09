import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:to_do_list/app/presentation/pages/record/record_controller.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({
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

    controller = Modular.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: controller.validateField,
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
                      onPressed: () async {
                        if (await controller.save()) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

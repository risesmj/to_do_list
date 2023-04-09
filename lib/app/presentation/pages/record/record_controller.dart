import 'package:flutter/material.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase.dart';
import 'package:uuid/uuid.dart';

class RecordController {
  late final CreateTaskUsecase createUsecase;
  late final formKey = GlobalKey<FormState>();
  var currentDescription = "";

  RecordController({
    required this.createUsecase,
  });

  void onChangeDescription(s) {
    currentDescription = s;
  }

  String? validateField(String? s) {
    if (s == null || s.isEmpty) {
      return "A descrição da tarefa não pode ser vazio.";
    }

    return null;
  }

  Future<bool> save() async {
    if (!formKey.currentState!.validate()) return false;

    try {
      final task = TaskEntity(
        id: const Uuid().v4(),
        done: false,
        description: currentDescription,
      );

      await createUsecase.call(task);
    } catch (e) {}

    return true;
  }
}

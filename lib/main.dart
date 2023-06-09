import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/app/app_module.dart';
import 'package:to_do_list/app/app_widget.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';

void main() async {
  Hive
    ..init(Directory.current.path)
    ..registerAdapter(
      TaskEntityAdapter(),
    );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

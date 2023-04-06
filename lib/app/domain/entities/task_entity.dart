import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  bool done;

  @HiveField(2)
  final String description;

  TaskEntity({
    required this.id,
    required this.done,
    required this.description,
  });
}

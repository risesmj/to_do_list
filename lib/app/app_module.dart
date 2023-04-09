import 'package:flutter_modular/flutter_modular.dart';
import 'package:to_do_list/app/domain/usecases/create/create_task_usecase_imp.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase.dart';
import 'package:to_do_list/app/domain/usecases/get/get_list_usecase_imp.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase.dart';
import 'package:to_do_list/app/domain/usecases/mark/mark_task_usecase_imp.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase.dart';
import 'package:to_do_list/app/domain/usecases/remove_at/remove_at_usecase_imp.dart';
import 'package:to_do_list/app/external/datasource/hive/to_do_list_hive_datasource.dart';
import 'package:to_do_list/app/infra/repositories/to_do_list_repository_imp.dart';
import 'package:to_do_list/app/presentation/pages/home/home_controller.dart';
import 'package:to_do_list/app/presentation/pages/home/home_page.dart';
import 'package:to_do_list/app/presentation/pages/home/home_store.dart';
import 'package:to_do_list/app/presentation/pages/record/record_controller.dart';
import 'package:to_do_list/app/presentation/pages/record/record_page.dart';

class AppModule extends Module {
  @override
  get binds => [
        Bind.factory(
          (i) => ToDoListHiveDatasource(),
        ),
        Bind.factory<RemoveAtUsecase>(
          (i) => RemoveAtUsecaseImp(
            repository: i(),
          ),
        ),
        Bind.factory<MarkTaskUsecase>(
          (i) => MarkTaskUsecaseImp(
            repository: i(),
          ),
        ),
        Bind.factory<GetListUsecase>(
          (i) => GetListUsecaseImp(
            repository: i(),
          ),
        ),
        Bind.factory(
          (i) => HomeStore(
            markTaskUsecase: i(),
            getUsecase: i(),
            removeAtUsecase: i(),
          ),
        ),
        Bind.singleton(
          (i) => ToDoListRepositoryImp(
            datasource: i(),
          ),
        ),
        Bind.singleton(
          (i) => HomeController(
            store: i(),
          ),
        ),
        Bind.factory(
          (i) => CreateTaskUsecaseImp(
            repository: i(),
          ),
        ),
        Bind.factory(
          (i) => RecordController(
            createUsecase: i(),
          ),
        )
      ];

  @override
  get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => const HomePage()),
        ),
        ChildRoute(
          '/new',
          child: ((context, args) => const RecordPage()),
        )
      ];
}

import 'package:to_do_list/app/presentation/pages/home/home_store.dart';

class HomeController {
  final HomeStore store;

  HomeController({
    required this.store,
  });

  void dispose() {
    store.destroy();
  }
}

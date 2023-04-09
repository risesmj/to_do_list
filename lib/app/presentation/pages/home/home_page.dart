import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:to_do_list/app/domain/entities/task_entity.dart';
import 'package:to_do_list/app/presentation/pages/home/home_controller.dart';
import 'package:to_do_list/app/presentation/pages/home/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Modular.get();
    controller.store.fetch();

    controller.store.observer(onError: ((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    }));
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
            await Modular.to.pushNamed('/new');
            controller.store.fetch();
          }),
      body: Center(
        child: TripleBuilder<HomeStore, String, List<TaskEntity>>(
          store: controller.store,
          builder: ((context, triple) {
            if (triple.isLoading) {
              return const CircularProgressIndicator();
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

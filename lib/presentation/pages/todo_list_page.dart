import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_techuni/presentation/widgets/text_field_dialig.dart';
import 'package:todo_techuni/use_case/todo/notifier/todo_notifier.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoNotifierProvider);
    final notifier = ref.read(todoNotifierProvider.notifier);
    useEffect(
      () {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          await notifier.getTodoList();
        });
        return;
      },
      const [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech.Uni'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () async {
              final String value = await showTextFieldDialog(context: context);
              await notifier.addTodo(description: value);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      child: Text(
                        state.todoList[index].description,
                        style: const TextStyle(fontSize: 22.0),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  );
                },
                itemCount: state.todoList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

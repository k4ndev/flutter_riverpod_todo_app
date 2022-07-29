import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/providers/all_provider.dart';
import 'package:flutter_riverpod_app/widgets/title_widget.dart';
import 'package:flutter_riverpod_app/widgets/todo_list_item_widget.dart';
import 'package:flutter_riverpod_app/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(
              labelText: 'New Todo',
            ),
            onSubmitted: (String value) {
              ref.read(toDoListProvider.notifier).addTodo(value);
              newTodoController.clear();
            },
          ),
          const SizedBox(height: 20),
          ToolbarWidget(),
          allTodos.isEmpty
              ? const Center(child: Text("You haven't todos"))
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              child: ProviderScope(overrides: [
                currentTodoProvider.overrideWithValue(allTodos[i]),
              ], child: const TodoListItemWidget()),
              onDismissed: (_) {
                ref.read(toDoListProvider.notifier).remove(allTodos[i]);
              },
            ),
        ],
      ),
    );
  }
}

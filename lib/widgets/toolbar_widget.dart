import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/providers/all_provider.dart';

class ToolbarWidget extends ConsumerWidget {
   ToolbarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filter) {
    return _currentFilter == filter ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int unComplatedCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          unComplatedCount.toString() + " todos",
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: "All Todos",
          child: TextButton(
            style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
            child: const Text("All"),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              debugPrint("All Todo");
            },
          ),
        ),
        Tooltip(
          message: "Active Todos",
          child: TextButton(
            style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.active)),
            child: const Text("Active"),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              debugPrint("Active Todo");
            },
          ),
        ),
        Tooltip(
          message: "Completed Todos",
          child: TextButton(
            style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.completed)),
            child: const Text("Completed"),
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
              debugPrint("Completed Todo");
            },
          ),
        ),
      ],
    );
  }
}

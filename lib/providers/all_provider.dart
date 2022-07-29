import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final toDoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), title: "Test1"),
    TodoModel(id: const Uuid().v4(), title: "Test2"),
    TodoModel(id: const Uuid().v4(), title: "Test3"),
    TodoModel(id: const Uuid().v4(), title: "Test4"),
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final toDoList = ref.watch(toDoListProvider);
  switch (filter) {
    case TodoListFilter.all:
      return toDoList;
    case TodoListFilter.active:
      return toDoList.where((element) => !element.completed).toList();
    case TodoListFilter.completed:
      return toDoList.where((element) => element.completed).toList();
  }
});

final unCompletedTodoCount = Provider((ref) {
  final allTodo = ref.watch(toDoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});

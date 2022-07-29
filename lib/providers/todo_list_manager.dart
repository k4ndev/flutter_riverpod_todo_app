import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialState]) : super(initialState ?? []);

  void addTodo(String title) {
    TodoModel todoModel = TodoModel(id: const Uuid().v4(), title: title);
    state = [...state, todoModel];
  }

  void toggle(String id) {
    //var model = state.firstWhere((element) => element.id == id);

    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(id: id, title: todo.title, completed: !todo.completed)
        else
          todo,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(id: id, title: title, completed: todo.completed)
        else
          todo,
    ];
  }

  void remove(TodoModel target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

  int unComplatedTodoCount() {
    return state.where((element) => !element.completed).length;
  }
}
